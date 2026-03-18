import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from '../shared/PageSectionRegistry';

export function Dashboard() {
    return (
        <PageTemplate 
            pageId="PG-419" 
             
            
            sectionData={PageSectionRegistry['PG-419']}
        />
    );
}
