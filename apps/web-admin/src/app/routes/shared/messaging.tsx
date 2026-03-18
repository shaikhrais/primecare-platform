import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "./PageSectionRegistry";

export default function MessagingPortal() {
    return (
        <PageTemplate 
            pageId="PG-736" 
            title="MessagingPortal" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-736']}
        />
    );
}
