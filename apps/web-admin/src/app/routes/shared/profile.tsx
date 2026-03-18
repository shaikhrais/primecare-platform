import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from './PageSectionRegistry';

export default function ProfilePage() {
    return (
        <PageTemplate 
            pageId="PG-815" 
             
            
            sectionData={PageSectionRegistry['PG-815']}
        />
    );
}
