import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

export default function SupportDashboard() {
    return (
        <PageTemplate 
            pageId="PG-828" 
            title="Support Inbox" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-828']}
        />
    );
}
