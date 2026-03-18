import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from CostOfCareCalculator.tsx ---
export function CostOfCareCalculator() {
    return (
        <PageTemplate 
            pageId="PGE-COC" 
            title="✨ Cost Of Care Calculator" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-COC']}
        />
    );
}

// --- Merged from LandingPageAbTester.tsx ---
export function LandingPageAbTester() {
    return (
        <PageTemplate 
            pageId="PGE-LPA" 
            title="✨ Landing Page Ab Tester" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-LPA']}
        />
    );
}

// --- Merged from LeadConversionFunnel.tsx ---
export function LeadConversionFunnel() {
    return (
        <PageTemplate 
            pageId="PGE-LCF" 
            title="✨ Lead Conversion Funnel" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-LCF']}
        />
    );
}

// --- Merged from LiveChatHandover.tsx ---
export function LiveChatHandover() {
    return (
        <PageTemplate 
            pageId="PGE-LCH" 
            title="✨ Live Chat Handover" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-LCH']}
        />
    );
}

// --- Merged from ReferralProgramTracker.tsx ---
export function ReferralProgramTracker() {
    return (
        <PageTemplate 
            pageId="PGE-RPT" 
            title="✨ Referral Program Tracker" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-RPT']}
        />
    );
}
