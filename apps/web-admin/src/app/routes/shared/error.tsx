import type { TableColumn } from '@/shared/components/sections';
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from NotFound.tsx ---
export function NotFound() {
    return (
        <PageTemplate 
            pageId="PGE-${Math.floor(Math.random() * 900 + 100)}" 
            title="Not Found" 
            subtitle="System Error Boundary"
            sectionData={{
                'mod.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'System Status', value: '100%', color: 'var(--pc-success)' },
                ]},
                'mod.body': { emptyState: { 
                    title: 'Not Found', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            }}
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
            sectionData={{
                'mod.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'System Status', value: '100%', color: 'var(--pc-success)' },
                ]},
                'mod.body': { emptyState: { 
                    title: 'Server Error', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            }}
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
            sectionData={{
                'mod.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'System Status', value: '100%', color: 'var(--pc-success)' },
                ]},
                'mod.body': { emptyState: { 
                    title: 'Unauthorized', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            }}
        />
    );
}
