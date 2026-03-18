import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from './PageSectionRegistry';

export default function VisitDetails() {
    return (
        <PageTemplate 
            pageId="PG-190" 
             
            
            sectionData={PageSectionRegistry['PG-190']}
        />
    );
}
