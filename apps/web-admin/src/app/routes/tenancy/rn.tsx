import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "..\shared\PageSectionRegistry";
import { apiClient } from '@/shared/utils/apiClient';
import { AdminRegistry } from 'prime-care-shared';

// --- Extracted from assessmentHelpers.ts ---
export interface Assessment {
    id: string; type: string; clientId: string; score: number; createdAt: string;
    client: { fullName: string; };
}

export function getTypePillClass(type: string): string {
    const t = type.toLowerCase();
    if (t.includes('adl')) return 'adl';
    if (t.includes('mobility')) return 'mobility';
    if (t.includes('cognitive')) return 'cognitive';
    return 'vital';
}

// --- Extracted from assessments.tsx ---
// Re-export from identity file: L18-AssessmentsHub.tsx
// removed broken export: export { default } from './L18-AssessmentsHub';


// --- Merged from L18-AssessmentsHub.tsx ---
export function AssessmentsHub() {
    return (
        <PageTemplate pageId="L18" title="Assessments Hub" subtitle="Clinical assessments, evaluations and care plan reviews"
            sectionData={PageSectionRegistry['L18']}
        />
    );
}

// --- Extracted from audit.tsx ---
// Re-export from identity file: T30-EntryVerify.tsx
// removed broken export: export { default } from './T30-EntryVerify';


// --- Merged from T30-EntryVerify.tsx ---
export function EntryVerify() {
    return (
        <PageTemplate pageId="T30" title="Entry Verification" subtitle="Verify and approve daily care entries and documentation"
            sectionData={PageSectionRegistry['T30']}
        />
    );
}

// --- Extracted from care-plans.tsx ---
// Re-export from identity file: T29-CarePlanManager.tsx
// removed broken export: export { default } from './T29-CarePlanManager';


// --- Merged from T29-CarePlanManager.tsx ---
export function CarePlanManager() {
    return (
        <PageTemplate pageId="T29" title="Care Plan Manager" subtitle="Create and manage individualized client care plans"
            sectionData={PageSectionRegistry['T29']}
        />
    );
}

// --- Extracted from dashboard.tsx ---
// Re-export from identity file: D15-RnDashboard.tsx
// removed broken export: export { default } from './D15-RnDashboard';


// --- Merged from D15-RnDashboard.tsx ---
// ================================================================
// PAGE IDENTITY: D15 — RN Dashboard
// Type: Dashboard | Owner: rn
// Converted: components/ deleted → PageTemplate + shared sections
// ================================================================



export function RnDashboard() {
    return (
        <PageTemplate pageId="D15" title="👩‍⚕️ RN Clinical Dashboard" subtitle="Patient assessments, delegations, care plans & medication oversight"
            sectionData={PageSectionRegistry['D15']}
        />
    );
}

// --- Extracted from mar.tsx ---
// --- Merged from D16-MarDashboard.tsx ---
export function MarDashboard() {
    return (
        <PageTemplate pageId="D16" title="MAR Dashboard" subtitle="Medication administration overview with compliance tracking"
            sectionData={PageSectionRegistry['D16']}
        />
    );
}

// --- Merged from T31-MarClient.tsx ---
export function MarClient() {
    return (
        <PageTemplate pageId="T31" title="eMAR Client" subtitle="Electronic medication administration record for client visits"
            sectionData={PageSectionRegistry['T31']}
        />
    );
}

// --- Extracted from marHandlers.ts ---
route: string; frequency: string;
    status: 'pending' | 'administered' | 'withheld';
    interactionLevel?: 'critical' | 'moderate' | 'none'; interactionMessage?: string;
}

export async function loadMedications(): Promise<Medication[]> {
    const cached = localStorage.getItem('primecare_emar_cache_123');
    if (cached && !navigator.onLine) return JSON.parse(cached);
    try {
        const res = await apiClient.get(AdminRegistry.ApiRegistry.RN.MAR_SCHEDULE('demo-client-1'));
        if (res.ok) { const data = await res.json(); localStorage.setItem('primecare_emar_cache_123', JSON.stringify(data)); return data as Medication[]; }
        throw new Error('Failed to fetch');
    } catch { if (cached) return JSON.parse(cached); return []; }
}

export async function commitAdministeredMeds(meds: Medication[]): Promise<boolean> {
    const administered = meds.filter(m => m.status === 'administered');
    try {
        for (const med of administered) {
            await apiClient.post(AdminRegistry.ApiRegistry.RN.MAR_ADMINISTER, {
                clientId: 'demo-client-1', medicationName: med.name, dosage: med.dose,
                route: med.route, scheduledTime: new Date().toISOString(), status: 'given'
            });
        }
        localStorage.removeItem('primecare_emar_cache_123');
        return true;
    } catch (e) { console.error('Failed to commit ledger:', e); return false; }
}

// --- Extracted from rai.tsx ---
// --- Merged from L19-RaiAssessments.tsx ---
export function RaiAssessments() {
    return (
        <PageTemplate pageId="L19" title="RAI Assessments" subtitle="Resident Assessment Instrument records and scoring"
            sectionData={PageSectionRegistry['L19']}
        />
    );
}

// --- Merged from T33-RaiAssessmentDetail.tsx ---
export function RaiAssessmentDetail() {
    return (
        <PageTemplate pageId="T33" title="RAI Assessment Detail" subtitle="Detailed RAI assessment form with scoring and care planning"
            sectionData={PageSectionRegistry['T33']}
        />
    );
}

// --- Extracted from schedule.tsx ---
// --- Merged from T63-RnCheckInScreen.tsx ---
export function RnCheckInScreen() {
    return (
        <PageTemplate pageId="T63" title="RN Check-In" subtitle="Nursing visit check-in with clinical assessment triggers"
            sectionData={PageSectionRegistry['T63']}
        />
    );
}

// --- Extracted from supervision.tsx ---
// Re-export from identity file: H16-SupervisionHub.tsx
// removed broken export: export { default } from './H16-SupervisionHub';


// --- Merged from H16-SupervisionHub.tsx ---
export function SupervisionHub() {
    return (
        <PageTemplate pageId="H16" title="Supervision Hub" subtitle="Staff supervision sessions, notes and delegation tracking"
            sectionData={PageSectionRegistry['H16']}
        />
    );
}

// --- Extracted from wound-care.tsx ---
onRegistry['WC']}
        />
    );
}


// --- Merged from D17-WoundCareDashboard.tsx ---
export function WoundCareDashboard_OLD() {
    return (
        <PageTemplate pageId="D17" title="Wound Care Dashboard" subtitle="Active wound assessments, healing progress and treatment protocols"
            sectionData={PageSectionRegistry['D17']}
        />
    );
}

// --- Merged from T32-WoundCareClient.tsx ---
export function WoundCareClient() {
    return (
        <PageTemplate pageId="T32" title="Wound Care Client" subtitle="Document wound assessments, measurements and treatment progress"
            sectionData={PageSectionRegistry['T32']}
        />
    );
}
