// ================================================================
// PAGE IDENTITY: S8 · Multi-Currency Settings
// Type: Settings | Owner: admin | Registry: S8
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import type { TableColumn } from '@/shared/components/sections';

const currencies = [
    { code: 'CAD 🇨🇦 (BASE)', name: 'Canadian Dollar', symbol: '$', rate: '1.0000', status: 'ACTIVE' },
    { code: 'USD 🇺🇸', name: 'US Dollar', symbol: '$', rate: '0.7412', status: 'ACTIVE' },
    { code: 'GBP 🇬🇧', name: 'British Pound', symbol: '£', rate: '0.5891', status: 'ACTIVE' },
    { code: 'EUR 🇪🇺', name: 'Euro', symbol: '€', rate: '0.6823', status: 'ACTIVE' },
    { code: 'INR 🇮🇳', name: 'Indian Rupee', symbol: '₹', rate: '61.45', status: 'INACTIVE' },
    { code: 'PHP 🇵🇭', name: 'Philippine Peso', symbol: '₱', rate: '41.28', status: 'INACTIVE' },
];

const currencyCols: TableColumn[] = [
    { key: 'code', label: 'Currency' }, { key: 'symbol', label: 'Symbol' },
    { key: 'rate', label: 'Rate (to CAD)' }, { key: 'status', label: 'Status' },
];

const fxTransactions = [
    { id: 'INV-2847', description: 'Invoice #INV-2847', conversion: 'USD $2,340 → CAD $3,157', rate: '1.3492', date: 'Mar 15' },
    { id: 'MED-UK', description: 'Supplier Payment — MedEquip UK', conversion: 'CAD $4,200 → GBP £2,474', rate: '0.5891', date: 'Mar 14' },
    { id: 'EU-CLIENT', description: 'Client Billing — EU Client', conversion: 'CAD $1,890 → EUR €1,290', rate: '0.6823', date: 'Mar 12' },
];

const fxCols: TableColumn[] = [
    { key: 'description', label: 'Transaction' }, { key: 'conversion', label: 'Conversion' },
    { key: 'rate', label: 'Rate' }, { key: 'date', label: 'Date' },
];

export default function MultiCurrencySettings() {
    return (
        <PageTemplate
            pageId="S8"
            title="💱 Multi-Currency Settings"
            subtitle="Exchange rates, conversions & international billing"
            actionPageId="admin.multi-currency"
            sectionData={{
                'S8.stats': { kpiCards: [
                    { label: 'Base Currency', value: 'CAD 🇨🇦', color: 'var(--pc-primary)' },
                    { label: 'Active Currencies', value: 4, color: 'var(--pc-success)' },
                    { label: 'Last Rate Update', value: '2 hrs ago', color: 'var(--pc-info, #2563EB)' },
                    { label: 'FX Transactions', value: 156, color: '#7C3AED' },
                ]},
                'S8.rate-table': { table: { columns: currencyCols, rows: currencies } },
                'S8.fx-history': { table: { columns: fxCols, rows: fxTransactions } },
            }}
        />
    );
}
