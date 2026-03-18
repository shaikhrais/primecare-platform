import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from './PageSectionRegistry';

export default function SupportHub() {
    return (
        <PageTemplate 
            pageId="PG-150" 
             
            
            sectionData={PageSectionRegistry['PG-150']}
        />
    );
}
