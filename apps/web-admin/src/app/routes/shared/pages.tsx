import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from './PageSectionRegistry';

// --- Merged from DevPreview.tsx ---
export function DevPreview() {
    return (
        <PageTemplate 
            pageId="PGE-DP" 
             
            
            sectionData={PageSectionRegistry['PGE-DP']}
        />
    );
}

// --- Merged from MarketingShowcase.tsx ---
export function MarketingShowcase() {
    return (
        <PageTemplate 
            pageId="PGE-${Math.floor(Math.random() * 900 + 100)}" 
             
            
            sectionData={PageSectionRegistry['COMPLEX_KEY_220']}
        />
    );
}

// --- Merged from RoleDashboardPlaceholder.tsx ---
export function RoleDashboardPlaceholder() {
    return (
        <PageTemplate 
            pageId="PG-178" 
             
            
            sectionData={PageSectionRegistry['PG-178']}
        />
    );
}
