import type { TableColumn } from '@/shared/components/sections';
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "./PageSectionRegistry";

// --- Merged from NotFound.tsx ---
export function NotFound() {
    return (
        <PageTemplate 
            pageId="PGE-${Math.floor(Math.random() * 900 + 100)}" 
            title="Not Found" 
            subtitle="System Error Boundary"
            sectionData={PageSectionRegistry['COMPLEX_KEY_215']}
        />
    );
}

// --- Merged from ServerError.tsx ---
export function ServerError() {
    return (
        <PageTemplate 
            pageId="PGE-${Math.floor(Math.random() * 900 + 100)}" 
            title="Server Error" 
            subtitle="System Error Boundary"
            sectionData={PageSectionRegistry['COMPLEX_KEY_216']}
        />
    );
}

// --- Merged from Unauthorized.tsx ---
export function Unauthorized() {
    return (
        <PageTemplate 
            pageId="PGE-${Math.floor(Math.random() * 900 + 100)}" 
            title="Unauthorized" 
            subtitle="System Error Boundary"
            sectionData={PageSectionRegistry['COMPLEX_KEY_217']}
        />
    );
}
