import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from H19-WizardHub.tsx ---
export function WizardHub() {
    return (
        <PageTemplate pageId="H19" title="Setup Wizards" subtitle="Guided setup workflows for platform configuration"
            sectionData={PageSectionRegistry['H19']}
        />
    );
}

// --- Merged from T12-BusinessStatus.tsx ---
// PAGE IDENTITY: T12 · Business Status

export function BusinessStatus() {
    return (
        <PageTemplate pageId="T12" title="📊 Business Status" subtitle="Organization setup progress, health checks & configuration completeness"
            sectionData={PageSectionRegistry['T12']}
        />
    );
}

// --- Merged from W1-BusinessSetupWizard.tsx ---
// PAGE IDENTITY: W1 · Business Setup Wizard

export function BusinessSetupWizard() {
    return (<PageTemplate pageId="W1" title="🏢 Business Setup Wizard" subtitle="Step-by-step guide to configure your organization"
        sectionData={PageSectionRegistry['W1']} />
    );
}

// --- Merged from W2-StaffOnboardingWizard.tsx ---
// PAGE IDENTITY: W2 · Staff Onboarding Wizard

export function StaffOnboardingWizard() {
    return (<PageTemplate pageId="W2" title="🎓 Staff Onboarding Wizard" subtitle="Guided PSW/RN onboarding — credentials, training & compliance"
        sectionData={PageSectionRegistry['W2']} />
    );
}

// --- Merged from W3-CarePlanWizard.tsx ---
// PAGE IDENTITY: W3 · Care Plan Wizard

export function CarePlanWizard() {
    return (<PageTemplate pageId="W3" title="📋 Care Plan Wizard" subtitle="Build individualized care plans with assessments, goals & interventions"
        sectionData={PageSectionRegistry['W3']} />
    );
}

// --- Merged from W4-RevenueWizard.tsx ---
// PAGE IDENTITY: W4 · Revenue Wizard

export function RevenueWizard() {
    return (<PageTemplate pageId="W4" title="💰 Revenue Configuration Wizard" subtitle="Configure billing, payer contracts, fee schedules & collection rules"
        sectionData={PageSectionRegistry['W4']} />
    );
}

// --- Merged from W5-BusinessModelWizard.tsx ---
// PAGE IDENTITY: W5 · Business Model Wizard

export function BusinessModelWizard() {
    return (<PageTemplate pageId="W5" title="🏗️ Business Model Wizard" subtitle="Configure franchise model, pricing tiers, territory & revenue sharing"
        sectionData={PageSectionRegistry['W5']} />
    );
}
