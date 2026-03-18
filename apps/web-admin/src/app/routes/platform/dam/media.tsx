import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from AssetExpirationManager.tsx ---
export function AssetExpirationManager() {
    return (
        <PageTemplate 
            pageId="PGE-AEM" 
            title="✨ Asset Expiration Manager" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-AEM']}
        />
    );
}

// --- Merged from CentralMediaVault.tsx ---
export function CentralMediaVault() {
    return (
        <PageTemplate 
            pageId="PGE-CMV" 
            title="✨ Central Media Vault" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-CMV']}
        />
    );
}

// --- Merged from MediaUsageHeatmap.tsx ---
export function MediaUsageHeatmap() {
    return (
        <PageTemplate 
            pageId="PGE-MUH" 
            title="✨ Media Usage Heatmap" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-MUH']}
        />
    );
}

// --- Merged from SecureDocumentRedactor.tsx ---
export function SecureDocumentRedactor() {
    return (
        <PageTemplate 
            pageId="PGE-SDR" 
            title="✨ Secure Document Redactor" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-SDR']}
        />
    );
}

// --- Merged from ThirdPartyCdnSync.tsx ---
export function ThirdPartyCdnSync() {
    return (
        <PageTemplate 
            pageId="PGE-TPC" 
            title="✨ Third Party Cdn Sync" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-TPC']}
        />
    );
}
