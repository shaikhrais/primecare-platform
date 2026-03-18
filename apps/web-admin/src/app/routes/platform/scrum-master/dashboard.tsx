// ================================================================
// Scrum Master Dashboard
// Converted: components/ deleted → PageTemplate + shared sections
// ================================================================
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

export default function ScrumMasterDashboard() {
    return (
        <PageTemplate pageId="SM" title="🏗️ Platform Health Center" subtitle="System health, endpoint coverage, technical governance & platform intelligence"
            sectionData={PageSectionRegistry['SM']}
        />
    );
}
