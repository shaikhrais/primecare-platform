import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "./PageSectionRegistry";

export default function SupportTicketForm() {
    return (
        <PageTemplate 
            pageId="PG-435" 
            title="Discard Ticket?" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-435']}
        />
    );
}
