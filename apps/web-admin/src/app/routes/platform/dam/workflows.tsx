import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from ApiEndpointRegistry.tsx ---
export function ApiEndpointRegistry() {
    return (
        <PageTemplate 
            pageId="PGE-AER" 
            title="✨ Api Endpoint Registry" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-AER']}
        />
    );
}

// --- Merged from ApiRateLimitConfig.tsx ---
export function ApiRateLimitConfig() {
    return (
        <PageTemplate 
            pageId="PGE-ARL" 
            title="✨ Api Rate Limit Config" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-ARL']}
        />
    );
}

// --- Merged from ErrorPayloadInspector.tsx ---
export function ErrorPayloadInspector() {
    return (
        <PageTemplate 
            pageId="PGE-EPI" 
            title="✨ Error Payload Inspector" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-EPI']}
        />
    );
}

// --- Merged from FormSchemaFederator.tsx ---
export function FormSchemaFederator() {
    return (
        <PageTemplate 
            pageId="PGE-FSF" 
            title="✨ Form Schema Federator" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-FSF']}
        />
    );
}

// --- Merged from VisualLogicBuilder.tsx ---
export function VisualLogicBuilder() {
    return (
        <PageTemplate 
            pageId="PGE-VLB" 
            title="✨ Visual Logic Builder" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-VLB']}
        />
    );
}

// --- Merged from WorkflowVersionControl.tsx ---
export function WorkflowVersionControl() {
    return (
        <PageTemplate 
            pageId="PGE-WVC" 
            title="✨ Workflow Version Control" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-WVC']}
        />
    );
}
