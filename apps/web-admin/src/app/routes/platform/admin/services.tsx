import { TableColumn } from '@/shared/components/sections/SectionTable';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
// Re-export from identity file: L5-Services.tsx
// removed broken export: export { default } from './L5-Services';


// --- Merged from L5-Services.tsx ---
// PAGE IDENTITY: L5 · Services




const services = [
    { code: 'PSW-HC', name: '🏠 PSW Home Care', rate: '$24.50/hr', clients: 45, status: '✅ Active' },
    { code: 'RN-WC', name: '🩺 RN Wound Care', rate: '$42.00/hr', clients: 12, status: '✅ Active' },
    { code: 'PSW-RC', name: '🛋️ Respite Care', rate: '$26.00/hr', clients: 8, status: '✅ Active' },
    { code: 'OT-AS', name: '🧩 OT Assessment', rate: '$55.00/hr', clients: 5, status: '✅ Active' },
    { code: 'PT-RH', name: '💪 PT Rehab', rate: '$52.00/hr', clients: 3, status: '✅ Active' },
    { code: 'PSW-PC', name: '🫧 PSW Personal Care', rate: '$24.50/hr', clients: 38, status: '✅ Active' },
];

const cols: TableColumn[] = [
    { key: 'code', label: 'Code' }, { key: 'name', label: 'Service' },
    { key: 'rate', label: 'Rate' }, { key: 'clients', label: 'Clients' },
    { key: 'status', label: 'Status' },
];

export function Services() {
    return (
        <PageTemplate pageId="L5" title="🏥 Service Catalog" subtitle="All service types, billing rates, capacity & eligibility requirements"
            sectionData={{
                'L5.stats': { kpiCards: [
                    { label: 'Service Types', value: 6, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 6, color: 'var(--pc-success)' },
                    { label: 'Total Clients', value: 111, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Avg Rate', value: '$37.33', color: '#7C3AED' },
                ]},
                'L5.table': { table: { columns: cols, rows: services } },
            }}
        />
    );
}