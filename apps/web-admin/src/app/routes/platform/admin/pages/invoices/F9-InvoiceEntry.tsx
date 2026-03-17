// PAGE IDENTITY: F9 · Invoice Entry
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function InvoiceEntry() {
    return (
        <PageTemplate pageId="F9" title="🧾 Invoice Entry" subtitle="Create and submit client invoices, service line items & payment terms"
            sectionData={{
                'F9.stats': { kpiCards: [
                    { label: 'Draft Invoices', value: 3, color: 'var(--pc-warning)' },
                    { label: 'Sent MTD', value: 12, color: 'var(--pc-primary)' },
                    { label: 'Total Billed', value: '$42.5K', color: 'var(--pc-success)' },
                    { label: 'Overdue', value: 1, color: 'var(--pc-error, #ef4444)' },
                ]},
                'F9.form': { cardGrid: { items: [
                    { icon: '👤', title: 'Client & Payer', subtitle: 'Select client, payer, billing address' },
                    { icon: '📋', title: 'Service Lines', subtitle: 'Add services, hours, rates & adjustments' },
                    { icon: '💰', title: 'Payment Terms', subtitle: 'Due date, payment method, late fees' },
                    { icon: '📧', title: 'Delivery', subtitle: 'Email, print, or electronic submission' },
                ], columns: 2 } },
            }}
        />
    );
}
