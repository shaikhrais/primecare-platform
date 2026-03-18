import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from '../shared/PageSectionRegistry';

// --- Merged from SystemPolicies.tsx ---
// PAGE IDENTITY: SystemPolicies · Platform Policies

export const SystemPolicies: React.FC = () => {
    return (
        <PageTemplate pageId="POLICIES" title="📜 System Policies" subtitle="Platform governance, privacy, compliance & regulatory policies"
            sectionData={PageSectionRegistry['POLICIES']}
        />
    );
};
