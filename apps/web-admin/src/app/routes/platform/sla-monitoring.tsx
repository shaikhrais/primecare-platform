import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from '../shared/PageSectionRegistry';

export default function SLAMonitoring() {
    return (
        <PageTemplate 
            pageId="PG-830" 
             
            
            sectionData={PageSectionRegistry['PG-830']}
        />
    );
}
