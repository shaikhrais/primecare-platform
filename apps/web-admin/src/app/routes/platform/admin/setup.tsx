import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from H19-WizardHub.tsx ---
export function WizardHub() {
    return (
        <PageTemplate pageId="H19" title="Setup Wizards" subtitle="Guided setup workflows for platform configuration"
            sectionData={{
                'H19.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}

// --- Merged from T12-BusinessStatus.tsx ---
// PAGE IDENTITY: T12 · Business Status

export function BusinessStatus() {
    return (
        <PageTemplate pageId="T12" title="📊 Business Status" subtitle="Organization setup progress, health checks & configuration completeness"
            sectionData={{
                'T12.stats': { kpiCards: [
                    { label: 'Setup Progress', value: '92%', color: 'var(--pc-success)' },
                    { label: 'Modules Active', value: '18/20', color: 'var(--pc-primary)' },
                    { label: 'Config Issues', value: 2, color: 'var(--pc-warning)' },
                    { label: 'Health Score', value: '98%', color: 'var(--pc-info, #2563EB)' },
                ]},
                'T12.modules': { cardGrid: { items: [
                    { icon: '✅', title: 'Organization Profile', subtitle: 'Complete — name, address, license' },
                    { icon: '✅', title: 'Billing Configuration', subtitle: 'Complete — payer setup, rates, tax codes' },
                    { icon: '✅', title: 'Staff Onboarding', subtitle: 'Complete — 82 PSWs, 4 RNs active' },
                    { icon: '⚠️', title: 'EMR Integration', subtitle: 'Pending — FHIR endpoint configuration' },
                    { icon: '✅', title: 'Compliance Documents', subtitle: 'Complete — HIPAA, PIPEDA, OHSA' },
                    { icon: '⚠️', title: 'Backup Configuration', subtitle: 'Pending — offsite backup schedule' },
                ], columns: 3 } },
            }}
        />
    );
}

// --- Merged from W1-BusinessSetupWizard.tsx ---
// PAGE IDENTITY: W1 · Business Setup Wizard

export function BusinessSetupWizard() {
    return (<PageTemplate pageId="W1" title="🏢 Business Setup Wizard" subtitle="Step-by-step guide to configure your organization"
        sectionData={{ 'W1.steps': { cardGrid: { items: [
            { icon: '1️⃣', title: 'Organization Info', subtitle: 'Legal name, address, business number' },
            { icon: '2️⃣', title: 'License & Compliance', subtitle: 'LHIN, MOH, OHIP provider number' },
            { icon: '3️⃣', title: 'Service Configuration', subtitle: 'Service types, rates, zones' },
            { icon: '4️⃣', title: 'Payment & Billing', subtitle: 'Bank info, payer setup, tax config' },
            { icon: '5️⃣', title: 'Integrations', subtitle: 'Email, SMS, EMR, EVV, payroll' },
            { icon: '6️⃣', title: 'Go Live', subtitle: 'Final checks, user invites, launch' },
        ], columns: 3 } } }} />
    );
}

// --- Merged from W2-StaffOnboardingWizard.tsx ---
// PAGE IDENTITY: W2 · Staff Onboarding Wizard

export function StaffOnboardingWizard() {
    return (<PageTemplate pageId="W2" title="🎓 Staff Onboarding Wizard" subtitle="Guided PSW/RN onboarding — credentials, training & compliance"
        sectionData={{ 'W2.steps': { cardGrid: { items: [
            { icon: '1️⃣', title: 'Personal Details', subtitle: 'Contact info, emergency contacts, demographics' },
            { icon: '2️⃣', title: 'Credentials', subtitle: 'CPR, First Aid, VSS, TB test, training certs' },
            { icon: '3️⃣', title: 'Training Modules', subtitle: 'HIPAA, WHMIS, platform training, safety' },
            { icon: '4️⃣', title: 'Go Live', subtitle: 'Supervisor sign-off, badge issue, first shift' },
        ], columns: 4 } } }} />
    );
}

// --- Merged from W3-CarePlanWizard.tsx ---
// PAGE IDENTITY: W3 · Care Plan Wizard

export function CarePlanWizard() {
    return (<PageTemplate pageId="W3" title="📋 Care Plan Wizard" subtitle="Build individualized care plans with assessments, goals & interventions"
        sectionData={{ 'W3.steps': { cardGrid: { items: [
            { icon: '1️⃣', title: 'Client Assessment', subtitle: 'RAI-HC, functional status, cognitive & risk factors' },
            { icon: '2️⃣', title: 'Goals & Outcomes', subtitle: 'SMART goals, measurement criteria, timeline' },
            { icon: '3️⃣', title: 'Interventions', subtitle: 'Service plan, frequency, provider assignments' },
            { icon: '4️⃣', title: 'Review & Approve', subtitle: 'Clinical review, family consent, publish' },
        ], columns: 4 } } }} />
    );
}

// --- Merged from W4-RevenueWizard.tsx ---
// PAGE IDENTITY: W4 · Revenue Wizard

export function RevenueWizard() {
    return (<PageTemplate pageId="W4" title="💰 Revenue Configuration Wizard" subtitle="Configure billing, payer contracts, fee schedules & collection rules"
        sectionData={{ 'W4.steps': { cardGrid: { items: [
            { icon: '1️⃣', title: 'Payer Setup', subtitle: 'OHIP, WSIB, CCAC, private insurers' },
            { icon: '2️⃣', title: 'Fee Schedules', subtitle: 'Service rates, modifiers, volume discounts' },
            { icon: '3️⃣', title: 'Billing Rules', subtitle: 'Auto-billing triggers, approval chains' },
            { icon: '4️⃣', title: 'Collections', subtitle: 'Aging thresholds, late fees, follow-up automation' },
        ], columns: 4 } } }} />
    );
}

// --- Merged from W5-BusinessModelWizard.tsx ---
// PAGE IDENTITY: W5 · Business Model Wizard

export function BusinessModelWizard() {
    return (<PageTemplate pageId="W5" title="🏗️ Business Model Wizard" subtitle="Configure franchise model, pricing tiers, territory & revenue sharing"
        sectionData={{ 'W5.steps': { cardGrid: { items: [
            { icon: '1️⃣', title: 'Model Selection', subtitle: 'Franchise, corporate, hybrid or white-label' },
            { icon: '2️⃣', title: 'Territory Setup', subtitle: 'Geographic zones, exclusive areas, overlap rules' },
            { icon: '3️⃣', title: 'Revenue Sharing', subtitle: 'Commission rates, royalty structure, payouts' },
            { icon: '4️⃣', title: 'Launch', subtitle: 'Branding, domains, onboarding materials' },
        ], columns: 4 } } }} />
    );
}
