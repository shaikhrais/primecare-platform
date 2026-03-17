// PAGE IDENTITY: T1 · Search Page
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function SearchPage() {
    return (
        <PageTemplate pageId="T1" title="🔍 Global Search" subtitle="Search across clients, PSWs, visits, documents, invoices & more"
            sectionData={{
                'T1.stats': { kpiCards: [
                    { label: 'Indexed Records', value: '45K', color: 'var(--pc-primary)' },
                    { label: 'Search Types', value: 8, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Searches Today', value: 142, color: 'var(--pc-success)' },
                ]},
                'T1.categories': { cardGrid: { items: [
                    { icon: '👥', title: 'Clients', subtitle: 'Search by name, ID, address or phone' },
                    { icon: '🏥', title: 'PSWs & Staff', subtitle: 'Search by name, badge, certifications' },
                    { icon: '📅', title: 'Visits & Shifts', subtitle: 'Search by date, client, PSW or status' },
                    { icon: '📄', title: 'Documents', subtitle: 'Search by type, provider or keyword' },
                    { icon: '🧾', title: 'Invoices & Claims', subtitle: 'Search by ID, client, payer or amount' },
                    { icon: '🚨', title: 'Incidents', subtitle: 'Search by type, date or severity' },
                ], columns: 3 } },
            }}
        />
    );
}
