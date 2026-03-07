import { FinancialService } from './financial.service';
import { Decimal } from '@prisma/client/runtime/library';

export class BillingService {
    private financialService: FinancialService;

    constructor(private prisma: any) {
        this.financialService = new FinancialService(prisma);
    }

    /**
     * Generates an invoice for a client and records it in the financial ledger.
     */
    async generateInvoice(params: {
        tenantId: string;
        clientId: string;
        amount: number | Decimal;
        tax?: number | Decimal;
    }) {
        const { tenantId, clientId, amount, tax = 0 } = params;
        const total = new Decimal(amount).plus(new Decimal(tax));

        return await this.prisma.$transaction(async (tx: any) => {
            // 1. Create the business record
            const invoice = await tx.invoice.create({
                data: {
                    tenantId,
                    clientId,
                    subtotal: new Decimal(amount),
                    tax: new Decimal(tax),
                    total,
                    status: 'posted'
                }
            });

            // 2. Create the financial ledger entries (AR/Revenue)
            await this.financialService.recordInvoice(tenantId, invoice.id, total);

            return invoice;
        });
    }

    /**
     * Processes a payment for an invoice and records it in the financial ledger.
     */
    async processPayment(params: {
        tenantId: string;
        invoiceId: string;
        amount: number | Decimal;
        method: string;
    }) {
        const { tenantId, invoiceId, amount, method } = params;

        return await this.prisma.$transaction(async (tx: any) => {
            // 1. Create the business record
            const payment = await tx.payment.create({
                data: {
                    invoiceId,
                    amount: new Decimal(amount),
                    status: 'completed'
                }
            });

            // 2. Update Invoice status if fully paid
            const invoice = await tx.invoice.findUnique({
                where: { id: invoiceId },
                include: { payments: true }
            });

            if (invoice) {
                const totalPaid = (invoice.payments as any[]).reduce((acc: any, p: any) => acc.plus(p.amount || 0), (this.prisma as any).Decimal(0)).plus((this.prisma as any).Decimal(amount));
                if (totalPaid.greaterThanOrEqualTo(invoice.total || 0)) {
                    await tx.invoice.update({
                        where: { id: invoiceId },
                        data: { status: 'paid' }
                    });
                }
            }

            // 3. Create the financial ledger entries (Cash/AR)
            await this.financialService.recordPayment(tenantId, payment.id, amount, invoiceId);

            return payment;
        });
    }

    /**
     * Records an expense and its ledger impact.
     */
    async recordExpense(params: {
        tenantId: string;
        category: string;
        amount: number | Decimal;
        description: string;
    }) {
        const { tenantId, category, amount, description } = params;

        // Map categories to account codes (simplified)
        const accountCode = category === 'PAYROLL' ? '5000' : '5100';

        return await this.financialService.recordTransaction({
            tenantId,
            type: 'EXPENSE',
            referenceId: 'MANUAL', // Or some document ID
            amount,
            entries: [
                { accountCode, debit: amount }, // Expense account
                { accountCode: '1000', credit: amount } // Cash
            ]
        });
    }
}
