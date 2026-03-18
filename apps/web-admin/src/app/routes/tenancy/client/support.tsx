import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from T35-ClientMessaging.tsx ---
export function ClientMessaging() {
    return (
        <PageTemplate pageId="T35" title="Client Messaging" subtitle="Secure messaging with your care team"
            sectionData={PageSectionRegistry['T35']}
        />
    );
}

// --- Merged from T37-FeedbackLoop.tsx ---
export function FeedbackLoop() {
    return (
        <PageTemplate pageId="T37" title="Feedback Loop" subtitle="Submit and track feedback on care quality and services"
            sectionData={PageSectionRegistry['T37']}
        />
    );
}
