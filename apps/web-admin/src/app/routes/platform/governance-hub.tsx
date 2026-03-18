import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from '../shared/PageSectionRegistry';

export default function GovernanceHub() {
    return (
        <PageTemplate 
            pageId="PG-307" 
             
            
            sectionData={PageSectionRegistry['PG-307']}
        />
    );
}
