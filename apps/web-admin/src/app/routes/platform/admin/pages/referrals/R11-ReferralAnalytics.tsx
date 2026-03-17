// PAGE IDENTITY: R11 · Referral Analytics
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function ReferralAnalytics() {
    return (
        <PageTemplate pageId="R11" title="📊 Referral Analytics" subtitle="Referral source analysis, conversion rates & pipeline metrics"
            sectionData={{
                'R11.stats': { kpiCards: [
                    { label: 'Total Referrals MTD', value: 28, color: 'var(--pc-primary)' },
                    { label: 'Conversion Rate', value: '72%', color: 'var(--pc-success)' },
                    { label: 'Top Source', value: 'CCAC', color: 'var(--pc-info, #2563EB)' },
                    { label: 'Avg Time to Serve', value: '3.2 days', color: '#7C3AED' },
                ]},
                'R11.by-source': { chart: { title: 'Referrals by Source', type: 'donut', data: [
                    { label: 'CCAC', value: 40, color: '#3B82F6' }, { label: 'Hospital', value: 25, color: '#10B981' },
                    { label: 'Physician', value: 20, color: '#F59E0B' }, { label: 'Self', value: 15, color: '#8B5CF6' },
                ]}},
                'R11.trend': { chart: { title: 'Monthly Referral Volume', type: 'bar', data: [
                    { label: 'Oct', value: 22 }, { label: 'Nov', value: 25 }, { label: 'Dec', value: 18 },
                    { label: 'Jan', value: 30 }, { label: 'Feb', value: 24 }, { label: 'Mar', value: 28 },
                ]}},
            }}
        />
    );
}
