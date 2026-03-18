import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from T34-CatalogBrowser.tsx ---
export function CatalogBrowser() {
    return (
        <PageTemplate pageId="T34" title="Service Catalog" subtitle="Browse available care services and request bookings"
            sectionData={PageSectionRegistry['T34']}
        />
    );
}
