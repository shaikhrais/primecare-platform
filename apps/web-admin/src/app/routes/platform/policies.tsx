import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from '../shared/PageSectionRegistry';

// --- Merged from SystemPolicies.tsx ---
// PAGE IDENTITY: SystemPolicies · Platform Policies

export const SystemPolicies: React.FC = () => {
    return (
        <PageTemplate pageId="POLICIES"  
            sectionData={PageSectionRegistry['POLICIES']}
        />
    );
};
