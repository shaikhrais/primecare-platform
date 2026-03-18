import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from './PageSectionRegistry';

export function Training() {
    return (
        <PageTemplate 
            pageId="PG-472" 
             
            
            sectionData={PageSectionRegistry['PG-472']}
        />
    );
}
