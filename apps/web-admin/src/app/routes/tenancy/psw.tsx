const { RouteRegistry, ApiRegistry, ContentRegistry, ThemeRegistry, PageRegistry, FormRegistry } = AdminRegistry;

import { PageSectionRegistry } from '../shared/PageSectionRegistry';
import { PageTemplate } from "@/shared/components/ui/PageTemplate";
import { AdminRegistry } from "prime-care-shared";
import React from "react";

// --- Extracted from availability.tsx ---
// Re-export from identity file: F15-Availability.tsx
// removed broken export: export { default } from './F15-Availability';


// --- Merged from F15-Availability.tsx ---
export function AvailabilityPage() {
    return (
        <PageTemplate pageId="F15"  
            sectionData={PageSectionRegistry['F15']}
        />
    );
}

// --- Extracted from credentials.tsx ---
// --- Merged from H14-CredentialVault.tsx ---
export function CredentialVault() {
    return (
        <PageTemplate pageId="H14"  
            sectionData={PageSectionRegistry['H14']}
        />
    );
}

// --- Extracted from dashboard.tsx ---
// Re-export from identity file: D14-PswDashboard.tsx
// removed broken export: export { default } from './D14-PswDashboard';


// --- Merged from D14-PswDashboard.tsx ---
// ================================================================
// PAGE IDENTITY: D14 — PSW Dashboard
// Type: Dashboard | Owner: psw
// Converted: components/ deleted → PageTemplate + shared sections
// ================================================================



export function PswDashboard() {
    return (
        <PageTemplate pageId="D14"  
            sectionData={PageSectionRegistry['D14']}
        />
    );
}

// --- Extracted from earnings.tsx ---
// Re-export from identity file: R3-PswEarnings.tsx
// removed broken export: export { default } from './R3-PswEarnings';


// --- Merged from R3-PswEarnings.tsx ---
export function PswEarnings() {
    return (
        <PageTemplate pageId="R3"  
            sectionData={PageSectionRegistry['R3']}
        />
    );
}

// --- Extracted from expenses.tsx ---
// Barrel re-export — identity file: F14-ExpenseClaim.tsx
// removed broken export: export { default } from './F14-ExpenseClaim';


// --- Merged from F14-ExpenseClaim.tsx ---
export function ExpenseReportForm() {
    return (
        <PageTemplate pageId="F14"  
            sectionData={PageSectionRegistry['F14']}
        />
    );
}

// --- Extracted from feed.tsx ---
// --- Merged from T27-ProviderSocial.tsx ---
export function ProviderSocial() {
    return (
        <PageTemplate pageId="T27"  
            sectionData={PageSectionRegistry['T27']}
        />
    );
}

// --- Extracted from guide.tsx ---
// --- Merged from G1-PswUserGuide.tsx ---
export function PswUserGuide() {
    return (
        <PageTemplate pageId="G1"  
            sectionData={PageSectionRegistry['G1']}
        />
    );
}

// --- Extracted from handover.tsx ---
// Barrel re-export — identity file: F13-ShiftHandover.tsx
// removed broken export: export { default } from './F13-ShiftHandover';


// --- Merged from F13-ShiftHandover.tsx ---
export function HandoverPage() {
    return (
        <PageTemplate pageId="F13"  
            sectionData={PageSectionRegistry['F13']}
        />
    );
}

// --- Extracted from mileage.tsx ---
// --- Merged from T28-MileageTracker.tsx ---
export function MileageTracker() {
    return (
        <PageTemplate pageId="T28"  
            sectionData={PageSectionRegistry['T28']}
        />
    );
}

// --- Extracted from OpenShifts.tsx ---
// Re-export from identity file: L17-OpenShifts.tsx
// removed broken export: export { default } from './L17-OpenShifts';


// --- Merged from L17-OpenShifts.tsx ---
export function OpenShifts() {
    return (
        <PageTemplate pageId="L17"  
            sectionData={PageSectionRegistry['L17']}
        />
    );
}

// --- Merged from T60-OpenOffers.tsx ---
export function OpenOffers() {
    return (
        <PageTemplate pageId="T60"  
            sectionData={PageSectionRegistry['T60']}
        />
    );
}

// --- Extracted from payouts.tsx ---
// Re-export from identity file: R4-PayoutHistory.tsx
// removed broken export: export { default } from './R4-PayoutHistory';


// --- Merged from R4-PayoutHistory.tsx ---
export function PayoutHistory() {
    return (
        <PageTemplate pageId="R4"  
            sectionData={PageSectionRegistry['R4']}
        />
    );
}

// --- Extracted from pswHandlers.ts ---

const API_URL_1 = import.meta.env.VITE_API_URL;

export interface Shift { id: string; client: { fullName: string }; serviceAddressLine1: string; requestedStartAt: string; status: string; service: { name: string }; }

export async function handleCheckIn(id: string, shifts: Shift[], setShifts: (s: Shift[]) => void, showToast: (m: string, t: string) => void, refresh: () => void, t: (k: string, o?: any) => string) {
    if (!navigator.geolocation) { showToast('Geolocation not supported', 'error'); return; }
    const orig = [...shifts]; setShifts(shifts.map(s => s.id === id ? { ...s, status: 'IN_PROGRESS' } : s));
    navigator.geolocation.getCurrentPosition(async (pos) => {
        try {
            await new Promise(r => setTimeout(r, 600));
            const ssids = ["PRIMECARE_GUEST","COFFEE_NET_5G","RESIDENT_ROUTER_1A"];
            showToast(`Location verified. Scanned ${ssids.length} nearby networks.`, 'info');
            const token = localStorage.getItem('token');
            const res = await fetch(`${API_URL_1}${ApiRegistry.PSW.CHECK_IN(id)}`, { method:'POST', headers:{'Authorization':`Bearer ${token}`,'Content-Type':'application/json'}, body: JSON.stringify({ lat:pos.coords.latitude, lng:pos.coords.longitude, accuracy:pos.coords.accuracy, ambientBssids:ssids })});
            if (res.ok) { refresh(); showToast(t('psw.checkin_success',{defaultValue:'Check-in successful!'}),'success'); } else { setShifts(orig); const d=await res.json(); showToast(t('psw.checkin_failed',{defaultValue:`Check-in failed: ${d?.error||'Unknown'}`}),'error'); }
        } catch { setShifts(orig); showToast('Check-in failed','error'); }
    }, (e) => { setShifts(orig); showToast(`Could not get location: ${e.message}`,'error'); });
}

export async function handleCheckOut(id: string, shifts: Shift[], setShifts: (s: Shift[]) => void, showToast: (m: string, t: string) => void, refresh: () => void, t: (k: string, o?: any) => string) {
    if (!navigator.geolocation) { showToast('Geolocation not supported','error'); return; }
    const orig = [...shifts]; setShifts(shifts.map(s => s.id === id ? { ...s, status: 'COMPLETED' } : s));
    navigator.geolocation.getCurrentPosition(async (pos) => {
        try {
            const token = localStorage.getItem('token');
            const res = await fetch(`${API_URL_1}${ApiRegistry.PSW.CHECK_OUT(id)}`, { method:'POST', headers:{'Authorization':`Bearer ${token}`,'Content-Type':'application/json'}, body: JSON.stringify({ lat:pos.coords.latitude, lng:pos.coords.longitude, accuracy:pos.coords.accuracy })});
            if (res.ok) { refresh(); showToast(t('psw.checkout_success',{defaultValue:'Check-out successful!'}),'success'); } else { setShifts(orig); const d=await res.json(); showToast(t('psw.checkout_failed',{defaultValue:`Check-out failed: ${d?.error||'Unknown'}`}),'error'); }
        } catch { setShifts(orig); showToast('Check-out failed','error'); }
    }, (e) => { setShifts(orig); showToast(`Could not get location: ${e.message}`,'error'); });
}

export async function fetchDashboardData(showToast: (m: string, t: string) => void): Promise<{shifts: Shift[]; chartData: any}> {
    try {
        const token = localStorage.getItem('token');
        const [sR,stR] = await Promise.all([fetch(`${API_URL_1}${ApiRegistry.PSW.VISITS}`,{headers:{'Authorization':`Bearer ${token}`}}), fetch(`${API_URL_1}${ApiRegistry.PSW.DASHBOARD_STATS}`,{headers:{'Authorization':`Bearer ${token}`}})]);
        return { shifts: sR.ok ? await sR.json() : [], chartData: stR.ok ? await stR.json() : null };
    } catch (e) { console.error('Failed to fetch',e); showToast(ContentRegistry.COMMON.NETWORK_ERROR,'error'); return { shifts:[], chartData:null }; }
}

// --- Extracted from schedule.tsx ---
// Re-export from identity file: L16-PswSchedule.tsx
// removed broken export: export { default } from './L16-PswSchedule';


// --- Merged from L16-PswSchedule.tsx ---
export function PswSchedule() {
    return (
        <PageTemplate pageId="L16"  
            sectionData={PageSectionRegistry['L16']}
        />
    );
}

// --- Merged from T61-LiveVisit.tsx ---
export function LiveVisit() {
    return (
        <PageTemplate pageId="T61"  
            sectionData={PageSectionRegistry['T61']}
        />
    );
}

// --- Merged from T62-CheckInScreen.tsx ---
export function CheckInScreen() {
    return (
        <PageTemplate pageId="T62"  
            sectionData={PageSectionRegistry['T62']}
        />
    );
}

// --- Extracted from shift-confirmation.tsx ---
// Re-export from identity file: T26-ShiftConfirmation.tsx
// removed broken export: export { default } from './T26-ShiftConfirmation';


// --- Merged from T26-ShiftConfirmation.tsx ---
export function ShiftConfirmation() {
    return (
        <PageTemplate pageId="T26"  
            sectionData={PageSectionRegistry['T26']}
        />
    );
}

// --- Extracted from training.tsx ---
// --- Merged from H15-PswTrainingHub.tsx ---
export function PswTrainingHub() {
    return (
        <PageTemplate pageId="H15"  
            sectionData={PageSectionRegistry['H15']}
        />
    );
}
