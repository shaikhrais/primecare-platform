import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from '../shared/PageSectionRegistry';

export default function TenantList() {
    return (
        <PageTemplate 
            pageId="PG-686" 
             
            
            sectionData={PageSectionRegistry['PG-686']}
        />
    );
}
