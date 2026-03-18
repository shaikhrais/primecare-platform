import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from T35-ClientMessaging.tsx ---
export function ClientMessaging() {
    return (
        <PageTemplate pageId="T35" title="Client Messaging" subtitle="Secure messaging with your care team"
            sectionData={{
                'T35.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}

// --- Merged from T37-FeedbackLoop.tsx ---
export function FeedbackLoop() {
    return (
        <PageTemplate pageId="T37" title="Feedback Loop" subtitle="Submit and track feedback on care quality and services"
            sectionData={{
                'T37.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}
