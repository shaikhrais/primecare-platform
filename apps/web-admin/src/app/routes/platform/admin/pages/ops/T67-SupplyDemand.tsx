// PAGE IDENTITY: T67 · Supply & Demand
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function SupplyDemand() {
    return (
        <PageTemplate pageId="T67" title="📊 Supply & Demand Analytics" subtitle="Staff capacity vs client demand — coverage gaps, forecasting & optimization"
            sectionData={{
                'T67.stats': { kpiCards: [
                    { label: 'Supply (PSWs)', value: 82, color: 'var(--pc-primary)' },
                    { label: 'Demand (Hrs/wk)', value: 3200, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Utilization', value: '87%', color: 'var(--pc-success)' },
                    { label: 'Coverage Gaps', value: 4, color: 'var(--pc-warning)' },
                ]},
                'T67.supply': { chart: { title: 'Supply vs Demand (Weekly)', type: 'bar', data: [
                    { label: 'Mon', value: 162, color: '#3B82F6' }, { label: 'Tue', value: 158, color: '#3B82F6' },
                    { label: 'Wed', value: 148, color: '#F59E0B' }, { label: 'Thu', value: 155, color: '#3B82F6' },
                    { label: 'Fri', value: 170, color: '#3B82F6' }, { label: 'Sat', value: 45, color: '#EF4444' },
                    { label: 'Sun', value: 32, color: '#EF4444' },
                ]}},
                'T67.forecast': { chart: { title: 'Demand Forecast (Next 4 Weeks)', type: 'bar', data: [
                    { label: 'Wk 12', value: 3200 }, { label: 'Wk 13', value: 3350 },
                    { label: 'Wk 14', value: 3100 }, { label: 'Wk 15', value: 3400 },
                ]}},
            }}
        />
    );
}
