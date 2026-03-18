import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from H4-SupplyChainHub.tsx ---
// PAGE IDENTITY: H4 · Supply Chain / ERP Hub

const erpModules = [
    { icon: '📦', title: 'Inventory Management', subtitle: 'Medical supplies, PPE, equipment tracking' },
    { icon: '🛒', title: 'Purchase Orders', subtitle: 'Vendor POs, approval workflows, delivery tracking' },
    { icon: '🏭', title: 'Vendor Management', subtitle: 'Supplier directory, contracts, performance' },
    { icon: '📊', title: 'Demand Forecasting', subtitle: 'AI-predicted supply needs by location' },
    { icon: '🔍', title: 'Asset Tracking', subtitle: 'Equipment lifecycle, maintenance schedules' },
    { icon: '💰', title: 'Cost Analysis', subtitle: 'Spend analytics, category management' },
];

export function SupplyChainHub() {
    return (
        <PageTemplate pageId="H4" title="📦 Supply Chain & ERP Hub" subtitle="Inventory, purchasing, vendor management & demand forecasting"
            sectionData={{
                'H4.stats': { kpiCards: [
                    { label: 'SKUs', value: 342, color: 'var(--pc-primary)' },
                    { label: 'Open POs', value: 5, color: 'var(--pc-warning)' },
                    { label: 'Low Stock', value: 3, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Vendors', value: 12, color: 'var(--pc-info, #2563EB)' },
                ]},
                'H4.modules': { cardGrid: { items: erpModules, columns: 3 } },
            }}
        />
    );
}
