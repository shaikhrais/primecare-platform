import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from DatabaseSchemaAudit.tsx ---
export function DatabaseSchemaAudit() {
    return (
        <PageTemplate 
            pageId="PGE-DSA" 
            title="✨ Database Schema Audit" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-DSA']}
        />
    );
}

// --- Merged from EnvironmentAudit.tsx ---
export function EnvironmentAudit() {
    return (
        <PageTemplate 
            pageId="PGE-EA" 
            title="✨ Environment Audit" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-EA']}
        />
    );
}

// --- Merged from InteractionAudit.tsx ---
export function InteractionAudit() {
    return (
        <PageTemplate 
            pageId="PG-207" 
            title="RESPONSE BOT" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-207']}
        />
    );
}

// --- Merged from RegistryIntegrityCheck.tsx ---
export function RegistryIntegrityCheck() {
    return (
        <PageTemplate 
            pageId="PGE-RIC" 
            title="✨ Registry Integrity Check" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-RIC']}
        />
    );
}

// --- Merged from ResponseBot.tsx ---
export function ResponseBot() {
    return (
        <PageTemplate 
            pageId="PGE-RB" 
            title="✨ Response Bot" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-RB']}
        />
    );
}

// --- Merged from TechnicalAuditPortal.tsx ---
export function TechnicalAuditPortal() {
    return (
        <PageTemplate 
            pageId="PGE-TAP" 
            title="✨ Technical Audit Portal" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-TAP']}
        />
    );
}
