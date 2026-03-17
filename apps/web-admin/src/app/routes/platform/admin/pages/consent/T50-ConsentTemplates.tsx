// PAGE IDENTITY: T50 · Consent Templates
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

const templates = [
    { icon: '📋', title: 'General Consent', subtitle: 'Standard service consent — annual renewal' },
    { icon: '📱', title: 'Telehealth Consent', subtitle: 'Virtual visit authorization — PHIPA compliant' },
    { icon: '💊', title: 'Medication Administration', subtitle: 'MAR consent for PSW-administered medications' },
    { icon: '📸', title: 'Photography/Video', subtitle: 'Media capture consent for documentation' },
    { icon: '🔬', title: 'Research Participation', subtitle: 'Optional research study consent' },
    { icon: '📊', title: 'Data Sharing', subtitle: 'Inter-provider health information sharing' },
];

export default function ConsentTemplates() {
    return (
        <PageTemplate pageId="T50" title="📄 Consent Templates" subtitle="Manage consent form templates, versions & digital signature workflows"
            sectionData={{
                'T50.stats': { kpiCards: [
                    { label: 'Templates', value: 6, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 5, color: 'var(--pc-success)' },
                    { label: 'Draft', value: 1, color: 'var(--pc-warning)' },
                ]},
                'T50.templates': { cardGrid: { items: templates, columns: 3 } },
            }}
        />
    );
}
