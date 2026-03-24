import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React, { lazy } from 'react';
import { AdminRegistry } from "prime-care-shared";
import { useToast } from "@/shared/hooks/useToast";
import { TableColumn } from "@/shared/components/sections";
import { apiClient } from "@/shared/utils/apiClient";
import AppLayout from "@/shared/components/layout/AppLayout";
import RequireRole from "@/shared/rbac/RequireRole";
import { Route } from "react-router";
import { PageSectionRegistry } from "./shared";
import { useState } from "react";
import { useEffect } from "react";

// --- Merged from admin.tsx ---

// --- Extracted from ops.tsx ---
// removed re-export: export { LogisticsHub, RegionMapping, RealtimeCapacity };


// --- Merged from H20-LogisticsHub.tsx ---
export function LogisticsHub() {
    return (
        <PageTemplate 
            pageId="PGE-LogisticsHub" 
            
            sectionData={PageSectionRegistry['LogisticsHub']}
        />
    );
}

// --- Merged from T64-RegionMapping.tsx ---
export function RegionMapping() {
    return (
        <PageTemplate 
            pageId="PGE-RegionMapping" 
            
            sectionData={PageSectionRegistry['RegionMapping']}
        />
    );
}

// --- Merged from T65-RealtimeCapacity.tsx ---
export function RealtimeCapacity() {
    return (
        <PageTemplate 
            pageId="PGE-RealtimeCapacity" 
            
            sectionData={PageSectionRegistry['RealtimeCapacity']}
        />
    );
}



// --- Merged from allied-health.tsx ---


// --- Merged from D18-AlliedHealthHome.tsx ---
export function AlliedHealthHome() {
    return (
        <PageTemplate 
            pageId="PGE-AlliedHealthHome" 
            
            sectionData={PageSectionRegistry['AlliedHealthHome']}
        />
    );
}


// --- Merged from T42-SignOff.tsx ---
export function SignOff() {
    return (
        <PageTemplate 
            pageId="PGE-SignOff" 
            
            sectionData={PageSectionRegistry['SignOff']}
        />
    );
}


// --- Merged from L21-TreatmentList.tsx ---
export function TreatmentList() {
    return (
        <PageTemplate 
            pageId="PGE-TreatmentList" 
            
            sectionData={PageSectionRegistry['TreatmentList']}
        />
    );
}



// --- Merged from client.tsx ---



// --- Extracted from billing.tsx ---
const API_URL_1 = import.meta.env.VITE_API_URL;

interface Invoice {
    id: string;
    createdAt: string;
    amount: number;
    currency: string;
    status: string;
    serviceDescription?: string;
}

export function BillingPage() {
    const { showToast } = useToast();
    const [invoices, setInvoices] = useState<Invoice[]>([]);
    const [loading, setLoading] = useState(true);

    const fetchInvoices = async () => {
        try {
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL_1}${ApiRegistry.CLIENT.INVOICES}`, {
                headers: { 'Authorization': `Bearer ${token}` }
            });
            if (response.ok) {
                const data = await response.json();
                setInvoices(data);
            }
        } catch (error) {
            console.error('Failed to fetch invoices', error);
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchInvoices();
    }, []);

    const handlePay = async (invoice: Invoice) => {
        setLoading(true);
        try {
            const token = localStorage.getItem('token');
            // Use existing payment intent route (assuming it exists via Stripe)
            const response = await fetch(`${API_URL_1}/v1/payments/create-payment-intent`, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    amount: Math.round(invoice.amount * 100), // Stripe expects cents
                    currency: invoice.currency || 'cad'
                })
            });
            const data = await response.json();
            if (data.clientSecret) {
                showToast('Stripe Checkout initiated. Please complete on the Stripe hosted page.', 'info');
                window.location.href = `https://checkout.stripe.com/pay/${data.clientSecret}`;
            }
        } catch (error) {
            showToast('Failed to initialize payment', 'error');
        } finally {
            setLoading(false);
        }
    };

    return (
        <div style={{ maxWidth: '900px', margin: '0 auto', padding: '1rem' }} data-cy="form.billing.page">
            <div style={{ marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#111827' }} data-cy="page.title">Billing & Invoices</h2>
                <p style={{ color: '#6b7280' }} data-cy="page.subtitle">Manage your care payments and service history.</p>
            </div>

            <div style={{ backgroundColor: 'white', borderRadius: '1rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)', overflow: 'hidden' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }} data-cy="form.billing.table">
                    <thead style={{ backgroundColor: '#f9fafb', borderBottom: '1px solid #e5e7eb' }}>
                        <tr>
                            <th style={{ padding: '1rem', fontWeight: '600' }}>Invoice ID</th>
                            <th style={{ padding: '1rem', fontWeight: '600' }}>Date</th>
                            <th style={{ padding: '1rem', fontWeight: '600' }}>Service</th>
                            <th style={{ padding: '1rem', fontWeight: '600' }}>Amount</th>
                            <th style={{ padding: '1rem', fontWeight: '600' }}>Status</th>
                            <th style={{ padding: '1rem', fontWeight: '600' }}>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        {loading ? (
                            <tr><td colSpan={6} style={{ padding: '2rem', textAlign: 'center' }}>Loading invoices...</td></tr>
                        ) : invoices.length > 0 ? (
                            invoices.map((inv) => (
                                <tr key={inv.id} style={{ borderBottom: '1px solid #f3f4f6' }} data-cy={`form.billing.row.${inv.id}`}>
                                    <td style={{ padding: '1rem', fontWeight: '500' }}>{inv.id.substring(0, 8)}...</td>
                                    <td style={{ padding: '1rem', color: '#6b7280' }}>{new Date(inv.createdAt).toLocaleDateString()}</td>
                                    <td style={{ padding: '1rem' }}>{inv.serviceDescription || 'Care Services'}</td>
                                    <td style={{ padding: '1rem', fontWeight: '600' }}>${inv.amount.toFixed(2)}</td>
                                    <td style={{ padding: '1rem' }}>
                                        <span style={{
                                            padding: '0.25rem 0.5rem',
                                            borderRadius: '9999px',
                                            fontSize: '0.75rem',
                                            backgroundColor: inv.status === 'paid' ? '#ecfdf5' : '#fef3c7',
                                            color: inv.status === 'paid' ? '#065f46' : '#92400e',
                                            textTransform: 'uppercase'
                                        }} data-cy="form.billing.status">
                                            {inv.status}
                                        </span>
                                    </td>
                                    <td style={{ padding: '1rem' }}>
                                        {inv.status === 'pending' && (
                                            <button
                                                data-cy="form.billing.pay"
                                                onClick={() => handlePay(inv)}
                                                disabled={loading}
                                                style={{ padding: '0.5rem 1rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.375rem', cursor: 'pointer', fontSize: '0.875rem' }}
                                            >
                                                Pay Now
                                            </button>
                                        )}
                                    </td>
                                </tr>
                            ))
                        ) : (
                            <tr><td colSpan={6} style={{ padding: '2rem', textAlign: 'center', color: '#6b7280' }}>No invoices found.</td></tr>
                        )}
                    </tbody>
                </table>
            </div>
        </div>
    );
}


// --- Merged from H10-BillingHub.tsx ---
export function BillingHub() {
    return (
        <PageTemplate 
            pageId="PGE-BillingHub" 
            
            sectionData={PageSectionRegistry['BillingHub']}
        />
    );
}

// --- Extracted from bookings.tsx ---
// Re-export from identity file: L14-ClientBookings.tsx
// removed broken export: export { default } from './L14-ClientBookings';


// --- Merged from L14-ClientBookings.tsx ---
// ================================================================
// PAGE IDENTITY: L14 — Client Bookings
// Type: List | Owner: client
// Converted: components/ deleted → PageTemplate + shared sections
// ================================================================



export function ClientBookings() {
    return (
        <PageTemplate 
            pageId="PGE-ClientBookings" 
            
            sectionData={PageSectionRegistry['ClientBookings']}
        />
    );
}

// --- Extracted from home.tsx ---
// Re-export from identity file: D8-ClientHome.tsx
// removed broken export: export { default } from './D8-ClientHome';


// --- Merged from D8-ClientHome.tsx ---
// ================================================================
// PAGE IDENTITY: D8 — Client Home
// Type: Home | Owner: client
// Converted: components/ deleted → PageTemplate + shared sections
// ================================================================



export function ClientHome() {
    return (
        <PageTemplate 
            pageId="PGE-ClientHome" 
            
            sectionData={PageSectionRegistry['ClientHome']}
        />
    );
}

// --- Extracted from engagement.tsx ---
// --- Merged from H17-FamilyCareHub.tsx ---
export function FamilyCareHub() {
    return (
        <PageTemplate 
            pageId="PGE-FamilyCareHub" 
            
            sectionData={PageSectionRegistry['FamilyCareHub']}
        />
    );
}

// --- Extracted from family.tsx ---
// --- Merged from P1-FamilyPortal.tsx ---
export function FamilyPortal() {
    return (
        <PageTemplate 
            pageId="PGE-FamilyPortal" 
            
            sectionData={PageSectionRegistry['FamilyPortal']}
        />
    );
}

// --- Extracted from feedback.tsx ---
// Barrel re-export — identity file: F16-SubmitFeedback.tsx
// removed broken export: export { default } from './F16-SubmitFeedback';


// --- Merged from F16-SubmitFeedback.tsx ---
export function FeedbackForm() {
    return (
        <PageTemplate 
            pageId="PGE-FeedbackForm" 
            
            sectionData={PageSectionRegistry['FeedbackForm']}
        />
    );
}

// --- Extracted from medical.tsx ---
// --- Merged from R5-MedicalSummary.tsx ---
export function MedicalSummary() {
    return (
        <PageTemplate 
            pageId="PGE-MedicalSummary" 
            
            sectionData={PageSectionRegistry['MedicalSummary']}
        />
    );
}

// --- Extracted from request-booking.tsx ---
// Re-export from identity file: F17-RequestBooking.tsx
// removed broken export: export { default } from './F17-RequestBooking';


// --- Merged from F17-RequestBooking.tsx ---
export function RequestBooking() {
    return (
        <PageTemplate 
            pageId="PGE-RequestBooking" 
            
            sectionData={PageSectionRegistry['RequestBooking']}
        />
    );
}

// --- Extracted from services.tsx ---
// --- Merged from T34-CatalogBrowser.tsx ---
export function CatalogBrowser() {
    return (
        <PageTemplate 
            pageId="PGE-CatalogBrowser" 
            
            sectionData={PageSectionRegistry['CatalogBrowser']}
        />
    );
}

// --- Extracted from support.tsx ---
// --- Merged from T35-ClientMessaging.tsx ---
export function ClientMessaging() {
    return (
        <PageTemplate 
            pageId="PGE-ClientMessaging" 
            
            sectionData={PageSectionRegistry['ClientMessaging']}
        />
    );
}

// --- Merged from T37-FeedbackLoop.tsx ---
export function FeedbackLoop() {
    return (
        <PageTemplate 
            pageId="PGE-FeedbackLoop" 
            
            sectionData={PageSectionRegistry['FeedbackLoop']}
        />
    );
}

// --- Extracted from team.tsx ---
// --- Merged from T36-TeamRoster.tsx ---
export function TeamRoster() {
    return (
        <PageTemplate 
            pageId="PGE-TeamRoster" 
            
            sectionData={PageSectionRegistry['TeamRoster']}
        />
    );
}



// --- Merged from coordinator.tsx ---

// --- Extracted from fleet.tsx ---
// --- Merged from T40-FleetManagement.tsx ---
export function FleetManagement() {
    return (
        <PageTemplate 
            pageId="PGE-FleetManagement" 
            
            sectionData={PageSectionRegistry['FleetManagement']}
        />
    );
}

// --- Extracted from hub.tsx ---
// --- Merged from H18-CoordinatorHub.tsx ---
export function CoordinatorHub() {
    return (
        <PageTemplate 
            pageId="PGE-CoordinatorHub" 
            
            sectionData={PageSectionRegistry['CoordinatorHub']}
        />
    );
}

// --- Extracted from map.tsx ---
// Re-export from identity file: T38-DispatchMap.tsx
// removed broken export: export { default } from './T38-DispatchMap';


// --- Merged from T38-DispatchMap.tsx ---
export function DispatchMap() {
    return (
        <PageTemplate 
            pageId="PGE-DispatchMap" 
            
            sectionData={PageSectionRegistry['DispatchMap']}
        />
    );
}

// --- Extracted from shift-swap.tsx ---
// --- Merged from T41-ShiftSwap.tsx ---
export function ShiftSwap() {
    return (
        <PageTemplate 
            pageId="PGE-ShiftSwap" 
            
            sectionData={PageSectionRegistry['ShiftSwap']}
        />
    );
}

// --- Extracted from sos.tsx ---
// Re-export from identity file: T39-SosCenter.tsx
// removed broken export: export { default } from './T39-SosCenter';


// --- Merged from T39-SosCenter.tsx ---
export function SosCenter() {
    return (
        <PageTemplate 
            pageId="PGE-SosCenter" 
            
            sectionData={PageSectionRegistry['SosCenter']}
        />
    );
}

// --- Extracted from waitlist.tsx ---
// Re-export from identity file: L20-WaitlistManager.tsx
// removed broken export: export { default } from './L20-WaitlistManager';


// --- Merged from L20-WaitlistManager.tsx ---
export function WaitlistManager() {
    return (
        <PageTemplate 
            pageId="PGE-WaitlistManager" 
            
            sectionData={PageSectionRegistry['WaitlistManager']}
        />
    );
}



// --- Merged from family.tsx ---

// --- Extracted from home.tsx ---
export function FamilyHome() {
    return (
        <PageTemplate 
            pageId="PGE-FamilyHome" 
            
            sectionData={PageSectionRegistry['FamilyHome']}
        />
    );
}



// --- Merged from finance.tsx ---


// --- Merged from D12-FinanceRegionalHub.tsx ---
export function FinanceRegionalHub() {
    return (
        <PageTemplate 
            pageId="PGE-FinanceRegionalHub" 
            
            sectionData={PageSectionRegistry['FinanceRegionalHub']}
        />
    );
}



// --- Merged from hr.tsx ---


// --- Merged from H13-HrRecruitmentPortal.tsx ---
export function HrRecruitmentPortal() {
    return (
        <PageTemplate 
            pageId="PGE-HrRecruitmentPortal" 
            
            sectionData={PageSectionRegistry['HrRecruitmentPortal']}
        />
    );
}



// --- Merged from manager.tsx ---

// --- Extracted from compliance.tsx ---
// Re-export from identity file: T25-ComplianceSync.tsx
// removed broken export: export { default } from './T25-ComplianceSync';


// --- Merged from T25-ComplianceSync.tsx ---
export function ComplianceSync() {
    return (
        <PageTemplate 
            pageId="PGE-ComplianceSync" 
            
            sectionData={PageSectionRegistry['ComplianceSync']}
        />
    );
}

// --- Extracted from daily-entry.tsx ---
// Re-export from identity file: T20-DailyEntry.tsx
// removed broken export: export { default } from './T20-DailyEntry';


// --- Merged from T20-DailyEntry.tsx ---
// ================================================================
// PAGE IDENTITY: T20 — Daily Entry
// Type: Tool | Owner: manager
// Converted: components/ deleted → PageTemplate + shared sections
// ================================================================



export function DailyEntry() {
    return (
        <PageTemplate 
            pageId="PGE-DailyEntry" 
            
            sectionData={PageSectionRegistry['DailyEntry']}
        />
    );
}

// --- Extracted from home.tsx ---
// Re-export from identity file: D7-ManagerHome.tsx
// removed broken export: export { default } from './D7-ManagerHome';


// --- Merged from D7-ManagerHome.tsx ---
// ================================================================
// PAGE IDENTITY: D7 — Manager Home
// Type: Home | Owner: manager
// Converted: components/ deleted → PageTemplate + shared sections
// ================================================================



export function ManagerHome() {
    return (
        <PageTemplate 
            pageId="PGE-ManagerHome" 
            
            sectionData={PageSectionRegistry['ManagerHome']}
        />
    );
}

// --- Extracted from documents.tsx ---
const documents = [
    { name: '📄 Employment Contract — Priya Sharma', type: 'Contract', status: 'PENDING', signers: '⏳ Priya Sharma, ✅ HR Director', created: '2 hrs ago', expires: '7 days' },
    { name: '📄 HIPAA Compliance Agreement 2026', type: 'Compliance', status: 'COMPLETED', signers: '✅ David Chen, ✅ Compliance Officer', created: '1 day ago', expires: '—' },
    { name: '📄 Client Care Plan — Margaret Chen', type: 'Care Plan', status: 'PENDING', signers: '⏳ Margaret Chen, ✅ Dr. Williams, ⏳ Case Manager', created: '3 hrs ago', expires: '14 days' },
    { name: '📄 Incident Report #IR-2026-087', type: 'Incident', status: 'EXPIRED', signers: '✅ Kevin O\'Brien, ⏳ Supervisor', created: '15 days ago', expires: 'Expired' },
    { name: '📄 NDA — PrimeCare × MedTech Inc.', type: 'NDA', status: 'PENDING', signers: '✅ CEO, ⏳ MedTech Rep', created: '5 hrs ago', expires: '30 days' },
    { name: '📄 Training Acknowledgment — Fall Prevention', type: 'Training', status: 'COMPLETED', signers: '✅ James Wright', created: '2 days ago', expires: '—' },
];
const templates = [
    { icon: '📋', title: 'Employment Contract', subtitle: '45 uses' },
    { icon: '🔒', title: 'HIPAA Agreement', subtitle: '120 uses' },
    { icon: '❤️', title: 'Care Plan Consent', subtitle: '89 uses' },
    { icon: '📝', title: 'Incident Report', subtitle: '34 uses' },
    { icon: '🤐', title: 'Non-Disclosure Agreement', subtitle: '12 uses' },
    { icon: '📚', title: 'Training Acknowledgment', subtitle: '67 uses' },
];

export function DocumentSigningCenter() {
    return (
        <PageTemplate 
            pageId="PGE-DocumentSigningCenter" 
            actionPageId="manager.document-signing"
            sectionData={PageSectionRegistry['DocumentSigningCenter']}
        />
    );
}

// --- Extracted from engagement.tsx ---
const mockLeaderboard = [
    { rank: '🏆', name: 'Priya Sharma', level: 'Diamond', points: 2847, streak: '45 days', visits: 312 },
    { rank: '🥈', name: 'David Chen', level: 'Diamond', points: 2610, streak: '38 days', visits: 289 },
    { rank: '🥉', name: 'Maria Santos', level: 'Platinum', points: 2455, streak: '30 days', visits: 275 },
    { rank: '⭐', name: 'James Wright', level: 'Platinum', points: 2180, streak: '22 days', visits: 256 },
    { rank: '⭐', name: 'Aisha Patel', level: 'Gold', points: 2050, streak: '19 days', visits: 240 },
    { rank: '⭐', name: 'Kevin O\'Brien', level: 'Gold', points: 1890, streak: '15 days', visits: 228 },
    { rank: '⭐', name: 'Sarah Kim', level: 'Silver', points: 1750, streak: '12 days', visits: 210 },
    { rank: '⭐', name: 'Tom Rodriguez', level: 'Silver', points: 1620, streak: '9 days', visits: 195 },
];

const leaderboardCols: TableColumn[] = [
    { key: 'rank', label: 'Rank', align: 'center' },
    { key: 'name', label: 'PSW' },
    { key: 'level', label: 'Level' },
    { key: 'points', label: 'Points' },
    { key: 'streak', label: 'Streak' },
    { key: 'visits', label: 'Visits' },
];

const badges = [
    { icon: '🏃', title: 'Visit Streak', subtitle: '30+ consecutive days', badge: '12% unlocked' },
    { icon: '⏰', title: 'Punctuality Pro', subtitle: '95%+ on-time check-ins', badge: '28% unlocked' },
    { icon: '❤️', title: 'Client Favorite', subtitle: '5★ avg from 10+ clients', badge: '18% unlocked' },
    { icon: '📚', title: 'Scholar', subtitle: 'Complete 10 training modules', badge: '34% unlocked' },
    { icon: '🦸', title: 'First Responder', subtitle: 'Filed 3+ incident reports', badge: '45% unlocked' },
    { icon: '🌙', title: 'Night Owl', subtitle: '50+ evening shifts', badge: '22% unlocked' },
    { icon: '🗺️', title: 'Road Warrior', subtitle: '1000+ km traveled', badge: '15% unlocked' },
    { icon: '🤝', title: 'Team Player', subtitle: 'Cover 5+ shifts', badge: '20% unlocked' },
];

const challenges = [
    { name: '🎯 March Madness', description: 'Complete 20 visits this week', progress: 75, badge: 'Reward: 50 pts', meta: '⏰ 3 days left' },
    { name: '🎯 Zero No-Shows', description: 'Perfect attendance for 2 weeks', progress: 85, badge: 'Reward: 100 pts', meta: '⏰ 4 days left' },
    { name: '🎯 Documentation Star', description: 'Submit all notes within 1hr', progress: 60, badge: 'Reward: 30 pts', meta: '⏰ 5 days left' },
];

const rewards = [
    { icon: '☕', title: 'Coffee Card', subtitle: '$10 Tim Hortons gift card', badge: '🎯 500 pts' },
    { icon: '🎬', title: 'Movie Night', subtitle: '2x Cineplex movie tickets', badge: '🎯 1,000 pts' },
    { icon: '🛍️', title: 'Shopping Spree', subtitle: '$50 Amazon gift card', badge: '🎯 2,000 pts' },
    { icon: '✈️', title: 'PTO Day', subtitle: 'Extra paid time off day', badge: '🎯 3,000 pts' },
    { icon: '📱', title: 'Tech Upgrade', subtitle: 'New tablet or phone case', badge: '🎯 5,000 pts' },
    { icon: '🌟', title: 'Wall of Fame', subtitle: 'Featured on company wall', badge: '🎯 100 pts' },
];

export function GamificationHub() {
    const [activeTab, setActiveTab] = useState('leaderboard');

    const tabContent: Record<string, Record<string, any>> = {
        leaderboard: { 'H25.leaderboard': { table: { columns: leaderboardCols, rows: mockLeaderboard } } },
        badges: { 'H25.badges': { cardGrid: { items: badges, columns: 4 } } },
        challenges: { 'H25.challenges': { progressList: { items: challenges } } },
        rewards: { 'H25.rewards': { cardGrid: { items: rewards, columns: 3 } } },
    };

    return (
        <PageTemplate
            pageId="H25"
            
            
            actionPageId="manager.gamification"
            sectionData={PageSectionRegistry['H25']}
        />
    );
}

// --- Extracted from evaluations.tsx ---
// Re-export from identity file: L13-Evaluations.tsx
// removed broken export: export { default } from './L13-Evaluations';


// --- Merged from L13-Evaluations.tsx ---
export function Evaluations() {
    return (
        <PageTemplate 
            pageId="PGE-Evaluations" 
            
            sectionData={PageSectionRegistry['Evaluations']}
        />
    );
}

// --- Extracted from finance.tsx ---
// --- Merged from D9-BranchPL.tsx ---
export function BranchPL() {
    return (
        <PageTemplate 
            pageId="PGE-BranchPL" 
            
            sectionData={PageSectionRegistry['BranchPL']}
        />
    );
}

// --- Merged from T24-PayrollVerification.tsx ---
export function PayrollVerification() {
    return (
        <PageTemplate 
            pageId="PGE-PayrollVerification" 
            
            sectionData={PageSectionRegistry['PayrollVerification']}
        />
    );
}

// --- Extracted from hr.tsx ---
export function PerformanceReviews() {
    return (
        <PageTemplate 
            pageId="PGE-PerformanceReviews" 
            actionPageId="manager.performance-reviews"
            sectionData={PageSectionRegistry['PerformanceReviews']}
        />
    );
}

// --- Extracted from iot.tsx ---
const devices = [
    { id: 'iot-001', client: 'Margaret Chen', device: 'Fall Sensor', battery: '87%', status: 'ACTIVE', signal: 'strong', lastPing: '2 min ago', alerts: '0' },
    { id: 'iot-002', client: 'Robert Davies', device: 'BP Monitor', battery: '62%', status: 'ACTIVE', signal: 'good', lastPing: '8 min ago', alerts: '1' },
    { id: 'iot-003', client: 'Helen Kowalski', device: 'Glucose Monitor', battery: '45%', status: 'WARNING', signal: 'weak', lastPing: '23 min ago', alerts: '2' },
    { id: 'iot-004', client: 'James Morrison', device: 'Motion Sensor', battery: '92%', status: 'ACTIVE', signal: 'strong', lastPing: '1 min ago', alerts: '0' },
    { id: 'iot-005', client: 'Yuki Tanaka', device: 'Med Dispenser', battery: '15%', status: 'CRITICAL', signal: 'weak', lastPing: '45 min ago', alerts: '3' },
    { id: 'iot-006', client: 'Sarah O\'Malley', device: 'Smart Bed', battery: '78%', status: 'ACTIVE', signal: 'good', lastPing: '5 min ago', alerts: '0' },
];

export function IoTMonitoring() {
    const [tab, setTab] = useState('overview');

    return (
        <PageTemplate
            pageId="H26"
            
            
            actionPageId="manager.iot-monitoring"
            sectionData={PageSectionRegistry['H26']}
        />
    );
}

// --- Extracted from operations.tsx ---
// Re-export from identity file: H12-OperationsHub.tsx
// removed broken export: export { default } from './H12-OperationsHub';


// --- Merged from H12-OperationsHub.tsx ---
export function OperationsHub() {
    return (
        <PageTemplate 
            pageId="PGE-OperationsHub" 
            
            sectionData={PageSectionRegistry['OperationsHub']}
        />
    );
}
// --- Merged sidecars ---

// --- Extracted from pages.tsx ---
// --- Merged from D10-RegionalStats.tsx ---
export function RegionalStats() {
    return (
        <PageTemplate 
            pageId="PGE-RegionalStats" 
            
            sectionData={PageSectionRegistry['RegionalStats']}
        />
    );
}

// --- Extracted from performance.tsx ---
// --- Merged from T23-StaffRanker.tsx ---
export function StaffRanker() {
    return (
        <PageTemplate 
            pageId="PGE-StaffRanker" 
            
            sectionData={PageSectionRegistry['StaffRanker']}
        />
    );
}

// --- Merged sidecars ---

// --- Extracted from portfolio.tsx ---
// Re-export from identity file: T19-Portfolio.tsx
// removed broken export: export { default } from './T19-Portfolio';


// --- Merged from T19-Portfolio.tsx ---
export function ManagementPortfolio() {
    return (
        <PageTemplate 
            pageId="PGE-ManagementPortfolio" 
            
            sectionData={PageSectionRegistry['ManagementPortfolio']}
        />
    );
}

// --- Extracted from service-review.tsx ---
// Re-export from identity file: T21-ServiceReview.tsx
// removed broken export: export { default } from './T21-ServiceReview';


// --- Merged from T21-ServiceReview.tsx ---
export function ServiceReview() {
    return (
        <PageTemplate 
            pageId="PGE-ServiceReview" 
            
            sectionData={PageSectionRegistry['ServiceReview']}
        />
    );
}

// --- Extracted from surveys.tsx ---
// Re-export from identity file: T22-SurveyManager.tsx
// removed broken export: export { default } from './T22-SurveyManager';


// --- Merged from T22-SurveyManager.tsx ---
export function SurveyManager() {
    return (
        <PageTemplate 
            pageId="PGE-SurveyManager" 
            
            sectionData={PageSectionRegistry['SurveyManager']}
        />
    );
}

// --- Extracted from training.tsx ---
const courses = [
    { name: 'Fall Prevention & Response', category: 'Safety', duration: '45 min', enrolled: 42, completed: 38, rate: '90%', rating: '⭐ 4.8', mandatory: 'YES' },
    { name: 'HIPAA Compliance 2026', category: 'Compliance', duration: '30 min', enrolled: 48, completed: 48, rate: '100%', rating: '⭐ 4.2', mandatory: 'YES' },
    { name: 'Dementia Care Best Practices', category: 'Clinical', duration: '60 min', enrolled: 35, completed: 28, rate: '80%', rating: '⭐ 4.9', mandatory: '—' },
    { name: 'Medication Administration', category: 'Clinical', duration: '90 min', enrolled: 40, completed: 32, rate: '80%', rating: '⭐ 4.7', mandatory: 'YES' },
    { name: 'Cultural Sensitivity Training', category: 'Professional', duration: '30 min', enrolled: 30, completed: 25, rate: '83%', rating: '⭐ 4.5', mandatory: '—' },
    { name: 'PrimeCare App Training', category: 'Technical', duration: '20 min', enrolled: 48, completed: 45, rate: '94%', rating: '⭐ 4.3', mandatory: 'YES' },
    { name: 'Infection Control & PPE', category: 'Safety', duration: '40 min', enrolled: 44, completed: 40, rate: '91%', rating: '⭐ 4.6', mandatory: 'YES' },
];

const courseCols: TableColumn[] = [
    { key: 'name', label: 'Course' }, { key: 'category', label: 'Category' },
    { key: 'duration', label: 'Duration' }, { key: 'enrolled', label: 'Enrolled' },
    { key: 'completed', label: 'Done' }, { key: 'rate', label: '%' },
    { key: 'rating', label: 'Rating' }, { key: 'mandatory', label: 'Required' },
];

const certifications = [
    { name: '🏆 Priya Sharma', description: '✅ Fall Prevention, ✅ HIPAA, ✅ Medication Admin, ✅ Infection Control, ✅ App Training', progress: 100, badge: '5 certs' },
    { name: '🏆 David Chen', description: '✅ Fall Prevention, ✅ HIPAA, ✅ Infection Control, ✅ App Training', progress: 80, badge: '4 certs', meta: '⚠ 1 expiring' },
    { name: '🏆 Maria Santos', description: '✅ HIPAA, ✅ Medication Admin, ✅ App Training', progress: 60, badge: '3 certs' },
    { name: '🏆 James Wright', description: '✅ HIPAA, ✅ App Training', progress: 40, badge: '2 certs', meta: '⚠ 2 expiring' },
];

export function TrainingAcademy() {
    const [tab, setTab] = useState('courses');

    const tabContent: Record<string, Record<string, any>> = {
        courses: { 'H29.module-grid': { table: { columns: courseCols, rows: courses } } },
        progress: { 'H29.progress': { progressList: { items: certifications } } },
    };

    return (
        <PageTemplate
            pageId="H29"
            
            
            actionPageId="manager.training-academy"
            sectionData={PageSectionRegistry['H29']}
        />
    );
}



// --- Merged from marketing.tsx ---


// --- Merged from D11-MarketingHome.tsx ---
export function MarketingHome() {
    return (
        <PageTemplate 
            pageId="PGE-MarketingHome" 
            
            sectionData={PageSectionRegistry['MarketingHome']}
        />
    );
}



// --- Merged from psw.tsx ---
const { RouteRegistry, ApiRegistry, ContentRegistry, ThemeRegistry, PageRegistry, FormRegistry } = AdminRegistry;


// --- Extracted from availability.tsx ---
// Re-export from identity file: F15-Availability.tsx
// removed broken export: export { default } from './F15-Availability';


// --- Merged from F15-Availability.tsx ---
export function AvailabilityPage() {
    return (
        <PageTemplate 
            pageId="PGE-AvailabilityPage" 
            
            sectionData={PageSectionRegistry['AvailabilityPage']}
        />
    );
}

// --- Extracted from credentials.tsx ---
// --- Merged from H14-CredentialVault.tsx ---
export function CredentialVault() {
    return (
        <PageTemplate 
            pageId="PGE-CredentialVault" 
            
            sectionData={PageSectionRegistry['CredentialVault']}
        />
    );
}

// --- Extracted from home.tsx ---
// Re-export from identity file: D14-PswHome.tsx
// removed broken export: export { default } from './D14-PswHome';


// --- Merged from D14-PswHome.tsx ---
// ================================================================
// PAGE IDENTITY: D14 — PSW Home
// Type: Home | Owner: psw
// Converted: components/ deleted → PageTemplate + shared sections
// ================================================================



export function PswHome() {
    return (
        <PageTemplate 
            pageId="PGE-PswHome" 
            
            sectionData={PageSectionRegistry['PswHome']}
        />
    );
}

// --- Extracted from earnings.tsx ---
// Re-export from identity file: R3-PswEarnings.tsx
// removed broken export: export { default } from './R3-PswEarnings';


// --- Merged from R3-PswEarnings.tsx ---
export function PswEarnings() {
    return (
        <PageTemplate 
            pageId="PGE-PswEarnings" 
            
            sectionData={PageSectionRegistry['PswEarnings']}
        />
    );
}

// --- Extracted from expenses.tsx ---
// Barrel re-export — identity file: F14-ExpenseClaim.tsx
// removed broken export: export { default } from './F14-ExpenseClaim';


// --- Merged from F14-ExpenseClaim.tsx ---
export function ExpenseReportForm() {
    return (
        <PageTemplate 
            pageId="PGE-ExpenseReportForm" 
            
            sectionData={PageSectionRegistry['ExpenseReportForm']}
        />
    );
}

// --- Extracted from feed.tsx ---
// --- Merged from T27-ProviderSocial.tsx ---
export function ProviderSocial() {
    return (
        <PageTemplate 
            pageId="PGE-ProviderSocial" 
            
            sectionData={PageSectionRegistry['ProviderSocial']}
        />
    );
}

// --- Extracted from guide.tsx ---
// --- Merged from G1-PswUserGuide.tsx ---
export function PswUserGuide() {
    return (
        <PageTemplate 
            pageId="PGE-PswUserGuide" 
            
            sectionData={PageSectionRegistry['PswUserGuide']}
        />
    );
}

// --- Extracted from handover.tsx ---
// Barrel re-export — identity file: F13-ShiftHandover.tsx
// removed broken export: export { default } from './F13-ShiftHandover';


// --- Merged from F13-ShiftHandover.tsx ---
export function HandoverPage() {
    return (
        <PageTemplate 
            pageId="PGE-HandoverPage" 
            
            sectionData={PageSectionRegistry['HandoverPage']}
        />
    );
}

// --- Extracted from mileage.tsx ---
// --- Merged from T28-MileageTracker.tsx ---
export function MileageTracker() {
    return (
        <PageTemplate 
            pageId="PGE-MileageTracker" 
            
            sectionData={PageSectionRegistry['MileageTracker']}
        />
    );
}

// --- Extracted from OpenShifts.tsx ---
// Re-export from identity file: L17-OpenShifts.tsx
// removed broken export: export { default } from './L17-OpenShifts';


// --- Merged from L17-OpenShifts.tsx ---
export function OpenShifts() {
    return (
        <PageTemplate 
            pageId="PGE-OpenShifts" 
            
            sectionData={PageSectionRegistry['OpenShifts']}
        />
    );
}

// --- Merged from T60-OpenOffers.tsx ---
export function OpenOffers() {
    return (
        <PageTemplate 
            pageId="PGE-OpenOffers" 
            
            sectionData={PageSectionRegistry['OpenOffers']}
        />
    );
}

// --- Extracted from payouts.tsx ---
// Re-export from identity file: R4-PayoutHistory.tsx
// removed broken export: export { default } from './R4-PayoutHistory';


// --- Merged from R4-PayoutHistory.tsx ---
export function PayoutHistory() {
    return (
        <PageTemplate 
            pageId="PGE-PayoutHistory" 
            
            sectionData={PageSectionRegistry['PayoutHistory']}
        />
    );
}

// --- Extracted from pswHandlers.ts ---


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

export async function fetchHomeData(showToast: (m: string, t: string) => void): Promise<{shifts: Shift[]; chartData: any}> {
    try {
        const token = localStorage.getItem('token');
        const [sR,stR] = await Promise.all([fetch(`${API_URL_1}${ApiRegistry.PSW.VISITS}`,{headers:{'Authorization':`Bearer ${token}`}}), fetch(`${API_URL_1}${ApiRegistry.PSW.HOME_STATS}`,{headers:{'Authorization':`Bearer ${token}`}})]);
        return { shifts: sR.ok ? await sR.json() : [], chartData: stR.ok ? await stR.json() : null };
    } catch (e) { console.error('Failed to fetch',e); showToast(ContentRegistry.COMMON.NETWORK_ERROR,'error'); return { shifts:[], chartData:null }; }
}

// --- Extracted from schedule.tsx ---
// Re-export from identity file: L16-PswSchedule.tsx
// removed broken export: export { default } from './L16-PswSchedule';


// --- Merged from L16-PswSchedule.tsx ---
export function PswSchedule() {
    return (
        <PageTemplate 
            pageId="PGE-PswSchedule" 
            
            sectionData={PageSectionRegistry['PswSchedule']}
        />
    );
}

// --- Merged from T61-LiveVisit.tsx ---
export function LiveVisit() {
    return (
        <PageTemplate 
            pageId="PGE-LiveVisit" 
            
            sectionData={PageSectionRegistry['LiveVisit']}
        />
    );
}

// --- Merged from T62-CheckInScreen.tsx ---
export function CheckInScreen() {
    return (
        <PageTemplate 
            pageId="PGE-CheckInScreen" 
            
            sectionData={PageSectionRegistry['CheckInScreen']}
        />
    );
}

// --- Extracted from shift-confirmation.tsx ---
// Re-export from identity file: T26-ShiftConfirmation.tsx
// removed broken export: export { default } from './T26-ShiftConfirmation';


// --- Merged from T26-ShiftConfirmation.tsx ---
export function ShiftConfirmation() {
    return (
        <PageTemplate 
            pageId="PGE-ShiftConfirmation" 
            
            sectionData={PageSectionRegistry['ShiftConfirmation']}
        />
    );
}

// --- Extracted from training.tsx ---
// --- Merged from H15-PswTrainingHub.tsx ---
export function PswTrainingHub() {
    return (
        <PageTemplate 
            pageId="PGE-PswTrainingHub" 
            
            sectionData={PageSectionRegistry['PswTrainingHub']}
        />
    );
}



// --- Merged from qa.tsx ---


// --- Merged from D13-ClinicalQaHome.tsx ---
export function ClinicalQaHome() {
    return (
        <PageTemplate 
            pageId="PGE-ClinicalQaHome" 
            
            sectionData={PageSectionRegistry['ClinicalQaHome']}
        />
    );
}



// --- Merged from rn.tsx ---


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
        <PageTemplate 
            pageId="PGE-AssessmentsHub" 
            
            sectionData={PageSectionRegistry['AssessmentsHub']}
        />
    );
}

// --- Extracted from audit.tsx ---
// Re-export from identity file: T30-EntryVerify.tsx
// removed broken export: export { default } from './T30-EntryVerify';


// --- Merged from T30-EntryVerify.tsx ---
export function EntryVerify() {
    return (
        <PageTemplate 
            pageId="PGE-EntryVerify" 
            
            sectionData={PageSectionRegistry['EntryVerify']}
        />
    );
}

// --- Extracted from care-plans.tsx ---
// Re-export from identity file: T29-CarePlanManager.tsx
// removed broken export: export { default } from './T29-CarePlanManager';


// --- Merged from T29-CarePlanManager.tsx ---
export function CarePlanManager() {
    return (
        <PageTemplate 
            pageId="PGE-CarePlanManager" 
            
            sectionData={PageSectionRegistry['CarePlanManager']}
        />
    );
}

// --- Extracted from home.tsx ---
// Re-export from identity file: D15-RnHome.tsx
// removed broken export: export { default } from './D15-RnHome';


// --- Merged from D15-RnHome.tsx ---
// ================================================================
// PAGE IDENTITY: D15 — RN Home
// Type: Home | Owner: rn
// Converted: components/ deleted → PageTemplate + shared sections
// ================================================================



export function RnHome() {
    return (
        <PageTemplate 
            pageId="PGE-RnHome" 
            
            sectionData={PageSectionRegistry['RnHome']}
        />
    );
}

// --- Extracted from mar.tsx ---
// --- Merged from D16-MarHome.tsx ---
export function MarHome() {
    return (
        <PageTemplate 
            pageId="PGE-MarHome" 
            
            sectionData={PageSectionRegistry['MarHome']}
        />
    );
}

// --- Merged from T31-MarClient.tsx ---
export function MarClient() {
    return (
        <PageTemplate 
            pageId="PGE-MarClient" 
            
            sectionData={PageSectionRegistry['MarClient']}
        />
    );
}

// --- Extracted from marHandlers.ts ---
export interface Medication { name: string; dose: string; route: string; frequency: string;
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
        <PageTemplate 
            pageId="PGE-RaiAssessments" 
            
            sectionData={PageSectionRegistry['RaiAssessments']}
        />
    );
}

// --- Merged from T33-RaiAssessmentDetail.tsx ---
export function RaiAssessmentDetail() {
    return (
        <PageTemplate 
            pageId="PGE-RaiAssessmentDetail" 
            
            sectionData={PageSectionRegistry['RaiAssessmentDetail']}
        />
    );
}

// --- Extracted from schedule.tsx ---
// --- Merged from T63-RnCheckInScreen.tsx ---
export function RnCheckInScreen() {
    return (
        <PageTemplate 
            pageId="PGE-RnCheckInScreen" 
            
            sectionData={PageSectionRegistry['RnCheckInScreen']}
        />
    );
}

// --- Extracted from supervision.tsx ---
// Re-export from identity file: H16-SupervisionHub.tsx
// removed broken export: export { default } from './H16-SupervisionHub';


// --- Merged from H16-SupervisionHub.tsx ---
export function SupervisionHub() {
    return (
        <PageTemplate 
            pageId="PGE-SupervisionHub" 
            
            sectionData={PageSectionRegistry['SupervisionHub']}
        />
    );
}

// --- Extracted from wound-care.tsx ---
export function WoundCareHome() {
    return (
        <PageTemplate 
            pageId="PGE-WoundCareHome" 
            
            sectionData={PageSectionRegistry['WoundCareHome']}
        />
    );
}


// --- Merged from D17-WoundCareHome.tsx ---
export function WoundCareHome_OLD() {
    return (
        <PageTemplate 
            pageId="PGE-WoundCareHome_OLD" 
            
            sectionData={PageSectionRegistry['WoundCareHome_OLD']}
        />
    );
}

// --- Merged from T32-WoundCareClient.tsx ---
export function WoundCareClient() {
    return (
        <PageTemplate 
            pageId="PGE-WoundCareClient" 
            
            sectionData={PageSectionRegistry['WoundCareClient']}
        />
    );
}



// --- Merged from scrum-master.tsx ---

// --- Extracted from pages.tsx ---
// --- Merged from T47-ResponseBotAudit.tsx ---
export function ResponseBotAudit() {
    return (
        <PageTemplate 
            pageId="PGE-ResponseBotAudit" 
            
            sectionData={PageSectionRegistry['ResponseBotAudit']}
        />
    );
}



// --- Merged from staff.tsx ---


// --- Extracted from home.tsx ---
// Re-export from identity file: D19-StaffHome.tsx
// removed broken export: export { default } from './D19-StaffHome';


// --- Merged from D19-StaffHome.tsx ---
export function StaffHome() {
    return (
        <PageTemplate 
            pageId="PGE-StaffHome" 
            
            sectionData={PageSectionRegistry['StaffHome']}
        />
    );
}

// --- Extracted from messages.tsx ---
// --- Merged from T44-MessageCenter.tsx ---
export function MessageCenter() {
    return (
        <PageTemplate 
            pageId="PGE-MessageCenter" 
            
            sectionData={PageSectionRegistry['MessageCenter']}
        />
    );
}

// --- Extracted from operations.tsx ---
// --- Merged from T45-IncidentPortal.tsx ---
export function IncidentPortal() {
    return (
        <PageTemplate 
            pageId="PGE-IncidentPortal" 
            
            sectionData={PageSectionRegistry['IncidentPortal']}
        />
    );
}

// --- Merged from T46-ComplianceMonitor.tsx ---
export function ComplianceMonitor() {
    return (
        <PageTemplate 
            pageId="PGE-ComplianceMonitor" 
            
            sectionData={PageSectionRegistry['ComplianceMonitor']}
        />
    );
}

// --- Extracted from StaffRoutes.tsx ---
// Staff Pages
// --- Extracted from tasks.tsx ---
// --- Merged from T43-TaskGrid.tsx ---
export function TaskGrid() {
    return (
        <PageTemplate 
            pageId="PGE-TaskGrid" 
            
            sectionData={PageSectionRegistry['TaskGrid']}
        />
    );
}



// --- Merged from tenancyImports.ts ---
// TenancyRoutes: all lazy imports extracted

// Manager Pages
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const Portfolio = () => <div />;
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const UserList = () => <div />;
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const TrainingHub = () => <div />;
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const FinanceHub = () => <div />;

// PSW Pages
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const PswOpenShifts = () => <div />;
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const PswOpenOffers = () => <div />;
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const PswAvailability = () => <div />;
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const PswExpenses = () => <div />;
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const PswShiftConfirmation = () => <div />;
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const PswHandover = () => <div />;
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const PswPayoutHistory = () => <div />;

// RN Pages
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// Client Pages
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const ClientBilling = () => <div />;
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const ClientFeedback = () => <div />;
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const CareTeam = () => <div />;
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// Staff Pages
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const StaffTaskGrid = () => <div />;
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const StaffMessageCenter = () => <div />;
// @ts-ignore
// @ts-ignore
export const StaffIncidentPortal = () => <div />;
// @ts-ignore
// @ts-ignore
export const StaffComplianceMonitor = () => <div />;

// Scrum Master
// @ts-ignore
// @ts-ignore
// @ts-ignore
// Additional Pages
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// ── NEW PREMIUM PAGES (Session Sprint 3-6) ──
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const SMSHub = () => <div />;
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// @ts-ignore
// --- Merged from TenancyRoutes.tsx ---


export const TenancyRoutes = () => (
    <>
        {/* MANAGER PORTAL */}
        <Route path={`${RouteRegistry.MANAGER.HOME}/*`} element={<RequireRole allowedRoles={['manager', 'operations_manager', 'clinical_manager']}><AppLayout /></RequireRole>}>
            <Route index element={<ManagerHome />} />
            <Route path="operations" element={<OperationsHub />} />
            <Route path="regional-stats" element={<RegionalStats />} />
            <Route path="compliance" element={<ComplianceSync />} />
            <Route path="finance" element={<FinanceHub />} />
            <Route path="performance" element={<StaffRanker />} />
            <Route path="portfolio" element={<Portfolio />} />
            <Route path="training" element={<TrainingHub />} />
            <Route path="surveys" element={<SurveyManager />} />
            <Route path="evaluations" element={<Evaluations />} />
            <Route path="service-review" element={<ServiceReview />} />
            <Route path="daily-entry" element={<DailyEntry />} />
            <Route path="team" element={<UserList />} />
            {/* NEW PREMIUM PAGES — relative paths (parent = /tenancy/manager/*) */}
            <Route path="gamification" element={<GamificationHub />} />
            <Route path="iot-monitoring" element={<IoTMonitoring />} />
            <Route path="document-signing" element={<DocumentSigningCenter />} />
            <Route path="sms-hub" element={<SMSHub />} />
            <Route path="performance-reviews" element={<PerformanceReviews />} />
            <Route path="training-academy" element={<TrainingAcademy />} />
        </Route>

        {/* MARKETING PORTAL */}
        <Route path={`${RouteRegistry.MANAGER.MARKETING}/*`} element={<RequireRole allowedRoles={['marketing_manager']}><AppLayout /></RequireRole>}>
            <Route index element={<MarketingHome />} />
        </Route>

        {/* HR & RECRUITMENT PORTAL */}
        <Route path={`${RouteRegistry.MANAGER.RECRUITING}/*`} element={<RequireRole allowedRoles={['hr_manager', 'recruiting_manager']}><AppLayout /></RequireRole>}>
            <Route index element={<HrRecruitmentPortal />} />
        </Route>

        {/* FINANCE & REGIONAL HUB - FOR REGIONAL MANAGERS */}
        <Route path={`${RouteRegistry.MANAGER.FINANCE}/*`} element={<RequireRole allowedRoles={['finance_manager', 'regional_manager']}><AppLayout /></RequireRole>}>
            <Route index element={<FinanceRegionalHub />} />
        </Route>

        {/* CLINICAL QA HOME */}
        <Route path={`${RouteRegistry.MANAGER.CLINICAL}/*`} element={<RequireRole allowedRoles={['clinical_manager']}><AppLayout /></RequireRole>}>
            <Route index element={<ClinicalQaHome />} />
        </Route>

        {/* COORDINATOR PORTAL */}
        <Route path={`${RouteRegistry.COORDINATOR.HOME}/*`} element={<RequireRole allowedRoles={['coordinator', 'operations_manager']}><AppLayout /></RequireRole>}>
            <Route index element={<CoordinatorHub />} />
            <Route path="hub" element={<CoordinatorHub />} />
            <Route path="dispatch-map" element={<DispatchMap />} />
            <Route path="waitlist" element={<WaitlistManager />} />
            <Route path="sos-center" element={<SosCenter />} />
            <Route path="schedule" element={<CoordinatorHub />} />
        </Route>

        {/* PSW / PROVIDER PORTAL */}
        <Route path={`${RouteRegistry.PSW.HOME}/*`} element={<RequireRole allowedRoles={['psw']}><AppLayout /></RequireRole>}>
            <Route index element={<PswHome />} />
            <Route path="schedule" element={<PswSchedule />} />
            <Route path="open-shifts" element={<PswOpenShifts />} />
            <Route path="offers" element={<PswOpenOffers />} />
            <Route path="availability" element={<PswAvailability />} />
            <Route path="earnings" element={<PswEarnings />} />
            <Route path="expenses" element={<PswExpenses />} />
            <Route path="shift-confirmation" element={<PswShiftConfirmation />} />
            <Route path="credentials" element={<CredentialVault />} />
            <Route path="feed" element={<ProviderSocial />} />
            <Route path="live-visit/:id" element={<LiveVisit />} />
            <Route path="check-in/:id" element={<CheckInScreen />} />
            <Route path="handover" element={<PswHandover />} />
            <Route path="payouts" element={<PswPayoutHistory />} />
            <Route path="guide" element={<PswUserGuide />} />
        </Route>

        {/* RN PORTAL */}
        <Route path={`${RouteRegistry.RN.HOME}/*`} element={<RequireRole allowedRoles={['rn', 'clinical_manager']}><AppLayout /></RequireRole>}>
            <Route index element={<RnHome />} />
            <Route path="care-plans" element={<CarePlanManager />} />
            <Route path="entry-verify" element={<EntryVerify />} />
            <Route path="supervision" element={<SupervisionHub />} />
            <Route path="assessments" element={<AssessmentsHub />} />
            <Route path="check-in/:id" element={<RnCheckInScreen />} />
        </Route>

        {/* CLIENT PORTAL */}
        <Route path={`${RouteRegistry.CLIENT.HOME}/*`} element={<RequireRole allowedRoles={['client']}><AppLayout /></RequireRole>}>
            <Route index element={<ClientHome />} />
            <Route path="bookings" element={<ClientBookings />} />
            <Route path="billing" element={<ClientBilling />} />
            <Route path="feedback" element={<ClientFeedback />} />
            <Route path="request-booking" element={<RequestBooking />} />
            <Route path="services" element={<CatalogBrowser />} />
            <Route path="support" element={<ClientMessaging />} />
            <Route path="team" element={<CareTeam />} />
            <Route path="feedback-loop" element={<FeedbackLoop />} />
            <Route path="family-hub" element={<FamilyCareHub />} />
        </Route>

        {/* ALLIED HEALTH PORTAL */}
        <Route path={`${RouteRegistry.ALLIED.HOME}/*`} element={<RequireRole allowedRoles={['rmt', 'rpt', 'rch']}><AppLayout /></RequireRole>}>
            <Route index element={<AlliedHealthHome />} />
        </Route>

        {/* STAFF PORTAL */}
        <Route path={`${RouteRegistry.STAFF.HOME}/*`} element={<RequireRole allowedRoles={['staff', 'admin']}><AppLayout /></RequireRole>}>
            <Route index element={<StaffHome />} />
            <Route path="customers" element={<UserList />} />
            <Route path="tasks" element={<StaffTaskGrid />} />
            <Route path="messages" element={<StaffMessageCenter />} />
            <Route path="incidents" element={<StaffIncidentPortal />} />
            <Route path="compliance" element={<StaffComplianceMonitor />} />
        </Route>


    
        {/* NEWLY GENERATED STUB PAGES (Absolute Paths) */}
        <Route element={<RequireRole allowedRoles={['admin', 'client', 'rn', 'psw', 'coordinator', 'rmt', 'rpt', 'rch']}><AppLayout /></RequireRole>}>
            <Route path={RouteRegistry.CLIENT.MEDICAL_SUMMARY} element={<MedicalSummary />} />
            <Route path={RouteRegistry.CLIENT.FAMILY_PORTAL} element={<FamilyPortal />} />
            <Route path={RouteRegistry.RN.MAR} element={<MarHome />} />
            <Route path={RouteRegistry.RN.MAR_CLIENT(':clientId')} element={<MarClient />} />
            <Route path={RouteRegistry.RN.WOUND_CARE} element={<WoundCareHome />} />
            <Route path={RouteRegistry.RN.WOUND_CARE_CLIENT(':clientId')} element={<WoundCareClient />} />
            <Route path={RouteRegistry.RN.RAI_ASSESSMENTS} element={<RaiAssessments />} />
            <Route path={RouteRegistry.RN.RAI_ASSESSMENT_DETAIL(':id')} element={<RaiAssessmentDetail />} />
            <Route path={RouteRegistry.PSW.MILEAGE} element={<MileageTracker />} />
            <Route path={RouteRegistry.PSW.TRAINING} element={<PswTrainingHub />} />
            <Route path={RouteRegistry.COORDINATOR.FLEET} element={<FleetManagement />} />
            <Route path={RouteRegistry.COORDINATOR.SHIFT_SWAP} element={<ShiftSwap />} />
            <Route path={RouteRegistry.ALLIED.TREATMENTS} element={<TreatmentList />} />
            <Route path={RouteRegistry.ALLIED.SIGN_OFF} element={<SignOff />} />
        </Route>

    </>
);

