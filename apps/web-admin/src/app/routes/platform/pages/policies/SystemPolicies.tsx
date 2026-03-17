// PAGE IDENTITY: SystemPolicies · Platform Policies
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

const policies = [
    { icon: '🔐', title: 'Privacy Policy (PIPEDA)', subtitle: 'Personal information collection, use & disclosure' },
    { icon: '🏥', title: 'HIPAA Compliance', subtitle: 'Protected health information safeguards' },
    { icon: '📋', title: 'Terms of Service', subtitle: 'Platform usage terms, SLAs & liability' },
    { icon: '🛡️', title: 'Security Policy', subtitle: 'Access control, encryption, incident response' },
    { icon: '📊', title: 'Data Retention', subtitle: '7-year retention, purge schedules, backup policy' },
    { icon: '♿', title: 'Accessibility', subtitle: 'WCAG 2.1 AA compliance, accommodations' },
];

export const SystemPolicies: React.FC = () => {
    return (
        <PageTemplate pageId="POLICIES" title="📜 System Policies" subtitle="Platform governance, privacy, compliance & regulatory policies"
            sectionData={{
                'POLICIES.modules': { cardGrid: { items: policies, columns: 3 } },
            }}
        />
    );
};

export default SystemPolicies;
