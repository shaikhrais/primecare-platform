// PAGE IDENTITY: F7 · Staff Onboarding
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function StaffOnboarding() {
    return (
        <PageTemplate pageId="F7" title="🎓 Staff Onboarding" subtitle="New hire onboarding workflow — credentials, training & compliance checklist"
            sectionData={{
                'F7.stats': { kpiCards: [
                    { label: 'In Progress', value: 4, color: 'var(--pc-warning)' },
                    { label: 'Completed MTD', value: 6, color: 'var(--pc-success)' },
                    { label: 'Avg Days', value: 5.2, color: 'var(--pc-primary)' },
                    { label: 'Pending Docs', value: 8, color: 'var(--pc-error, #ef4444)' },
                ]},
                'F7.steps': { cardGrid: { items: [
                    { icon: '📋', title: 'Application Review', subtitle: 'Resume screening, reference checks, interview' },
                    { icon: '📄', title: 'Document Collection', subtitle: 'ID, VSS, CPR, First Aid, TB test, proof of training' },
                    { icon: '🎓', title: 'Training Modules', subtitle: 'HIPAA, WHMIS, Client Safety, Platform Use' },
                    { icon: '✅', title: 'Compliance Sign-Off', subtitle: 'Manager approval, credential verification, go-live' },
                ], columns: 4 } },
            }}
        />
    );
}
