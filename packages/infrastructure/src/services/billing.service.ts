import { FinancialService } from './financial.service';

/** Lightweight Decimal for Cloudflare Workers (replaces @prisma/client Decimal) */
class Decimal {
    private value: number;
    constructor(v: number | string | Decimal) {
        this.value = typeof v === 'object' && v instanceof Decimal ? v.toNumber() : Number(v);
    }
    times(other: number | string | Decimal) { return new Decimal(this.value * new Decimal(other).toNumber()); }
    dividedBy(other: number | string | Decimal) { return new Decimal(this.value / new Decimal(other).toNumber()); }
    plus(other: number | string | Decimal) { return new Decimal(this.value + new Decimal(other).toNumber()); }
    greaterThanOrEqualTo(other: number | string | Decimal) { return this.value >= new Decimal(other).toNumber(); }
    toNumber() { return this.value; }
    toString() { return this.value.toString(); }
    toJSON() { return this.value; }
}

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
        amount: number;
        tax?: number;
    }) {
        let { tenantId, clientId, amount, tax } = params;

        // 1. Fetch tax settings from tenant if tax amount not explicitly provided
        if (tax === undefined) {
            let tenant = null;
            try {
              tenant = this.prisma.tenant.findUnique({
                            where: { id: tenantId },
                            select: { taxPercentage: true }
                        });
            } catch(e) {
              console.error("Invalid UUID fallback", e);
            }
            const taxPct = new Decimal((tenant?.taxPercentage || 0).toString());
            tax = new Decimal(amount).times(taxPct.dividedBy(100)).toNumber();
        }

        const total = new Decimal(amount).plus(new Decimal(tax ?? 0));

        return await this.prisma.$transaction(async (tx: any) => {
            // 2. Create the business record
            const invoice = await tx.invoice.create({
                data: {
                    tenantId,
                    clientId,
                    subtotal: new Decimal(amount).toNumber(),
                    tax: new Decimal(tax ?? 0).toNumber(),
                    total: total.toNumber(),
                    status: 'posted'
                }
            });

            // 3. Create the financial ledger entries (AR/Revenue/Tax)
            await this.financialService.recordInvoice(tenantId, invoice.id, Number(amount), Number(tax!));

            return invoice;
        });
    }

    /**
     * Processes a payment for an invoice and records it in the financial ledger.
     */
    async processPayment(params: {
        tenantId: string;
        invoiceId: string;
        amount: number;
        method: string;
    }) {
        const { tenantId, invoiceId, amount, method } = params;

        return await this.prisma.$transaction(async (tx: any) => {
            // 1. Create the business record
            const payment = await tx.payment.create({
                data: {
                    invoiceId,
                    amount: new Decimal(amount).toNumber(),
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
            await this.financialService.recordPayment(tenantId, payment.id, Number(amount), invoiceId);

            return payment;
        });
    }

    /**
     * Records an expense and its ledger impact.
     */
    async recordExpense(params: {
        tenantId: string;
        category: string;
        amount: number;
        description: string;
    }) {
        const { tenantId, category, amount, description } = params;

        // Map categories to account codes (simplified)
        const accountCode = category === 'PAYROLL' ? '5000' : '5100';

        return await this.financialService.recordTransaction({
            tenantId,
            type: 'EXPENSE',
            referenceId: 'MANUAL', // Or some document ID
            amount: Number(amount),
            entries: [
                { accountCode, debit: Number(amount) }, // Expense account
                { accountCode: '1000', credit: Number(amount) } // Cash
            ]
        });
    }
}
