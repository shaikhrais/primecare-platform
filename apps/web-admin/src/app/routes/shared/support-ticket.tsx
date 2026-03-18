import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from './PageSectionRegistry';

export default function SupportTicketForm() {
    return (
        <PageTemplate 
            pageId="PG-435" 
             
            
            sectionData={PageSectionRegistry['PG-435']}
        />
    );
}
