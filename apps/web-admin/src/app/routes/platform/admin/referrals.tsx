import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from L9-ReferralList.tsx ---
// PAGE IDENTITY: L9 · Referral List
import type { TableColumn } from '@/shared/components/sections';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";
const cols: TableColumn[] = [
    { key: 'id', label: 'Ref ID' }, { key: 'source', label: 'Source' },
    { key: 'client', label: 'Client' }, { key: 'service', label: 'Service' },
    { key: 'received', label: 'Received' }, { key: 'status', label: 'Status' },
];

export function ReferralList() {
    return (
        <PageTemplate pageId="L9" title="🔗 Referral Pipeline" subtitle="Incoming referrals, intake tracking & source analytics"
            sectionData={PageSectionRegistry['L9']}
        />
    );
}

// --- Merged from R11-ReferralAnalytics.tsx ---
// PAGE IDENTITY: R11 · Referral Analytics

export function ReferralAnalytics() {
    return (
        <PageTemplate pageId="R11" title="📊 Referral Analytics" subtitle="Referral source analysis, conversion rates & pipeline metrics"
            sectionData={PageSectionRegistry['R11']}
        />
    );
}
