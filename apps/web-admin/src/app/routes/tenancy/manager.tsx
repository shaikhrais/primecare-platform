import { PageSectionRegistry } from "@/shared/PageSectionRegistry";
import { TableColumn } from "@/shared/components/sections";
import { PageTemplate } from "@/shared/components/ui/PageTemplate";
import React, { useState } from "react";

// --- Extracted from compliance.tsx ---
// Re-export from identity file: T25-ComplianceSync.tsx
// removed broken export: export { default } from './T25-ComplianceSync';


// --- Merged from T25-ComplianceSync.tsx ---
export function ComplianceSync() {
    return (
        <PageTemplate pageId="T25" title="Compliance Sync" subtitle="Regulatory compliance status and document synchronization"
            sectionData={PageSectionRegistry['T25']}
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
        <PageTemplate pageId="T20" title="📝 Daily Entry" subtitle="Record ADLs, vitals & wellness observations for client visits"
            sectionData={PageSectionRegistry['T20']}
        />
    );
}

// --- Extracted from dashboard.tsx ---
// Re-export from identity file: D7-ManagerDashboard.tsx
// removed broken export: export { default } from './D7-ManagerDashboard';


// --- Merged from D7-ManagerDashboard.tsx ---
// ================================================================
// PAGE IDENTITY: D7 — Manager Dashboard
// Type: Dashboard | Owner: manager
// Converted: components/ deleted → PageTemplate + shared sections
// ================================================================



export function ManagerDashboard() {
    return (
        <PageTemplate pageId="D7" title="📊 Manager Dashboard" subtitle="Branch operations, staff performance & business intelligence"
            sectionData={PageSectionRegistry['D7']}
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
            pageId="H27"
            title="✍️ Document Signing Center"
            subtitle="Digital signatures, audit trails & compliance documents"
            actionPageId="manager.document-signing"
            sectionData={PageSectionRegistry['H27']}
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
            title="🎮 Gamification Hub"
            subtitle="PSW engagement, achievements, streaks & rewards"
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
        <PageTemplate pageId="L13" title="Performance Evaluations" subtitle="Staff evaluation records, scores and improvement plans"
            sectionData={PageSectionRegistry['L13']}
        />
    );
}

// --- Extracted from finance.tsx ---
// --- Merged from D9-BranchPL.tsx ---
export function BranchPL() {
    return (
        <PageTemplate pageId="D9" title="Branch P&L" subtitle="Branch-level profit and loss analysis with margin tracking"
            sectionData={PageSectionRegistry['D9']}
        />
    );
}

// --- Merged from T24-PayrollVerification.tsx ---
export function PayrollVerification() {
    return (
        <PageTemplate pageId="T24" title="Payroll Verification" subtitle="Verify timesheets, approve hours and process payroll"
            sectionData={PageSectionRegistry['T24']}
        />
    );
}

// --- Extracted from hr.tsx ---
export function PerformanceReviews() {
    return (
        <PageTemplate
            pageId="L23"
            title="📊 Performance Reviews"
            subtitle="Q1 2026 — PSW performance evaluations"
            actionPageId="manager.performance-reviews"
            sectionData={PageSectionRegistry['L23']}
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
            title="📡 IoT & Wearable Monitoring"
            subtitle="Real-time health device monitoring, alerts & predictive insights"
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
        <PageTemplate pageId="H12" title="Operations Hub" subtitle="Approval workflows, incident management and organizational oversight"
            sectionData={PageSectionRegistry['H12']}
        />
    );
}
// --- Merged sidecars ---

// --- Extracted from pages.tsx ---
// --- Merged from D10-RegionalStats.tsx ---
export function RegionalStats() {
    return (
        <PageTemplate pageId="D10" title="Regional Statistics" subtitle="Regional performance metrics and KPI comparisons"
            sectionData={PageSectionRegistry['D10']}
        />
    );
}

// --- Extracted from performance.tsx ---
// --- Merged from T23-StaffRanker.tsx ---
export function StaffRanker() {
    return (
        <PageTemplate pageId="T23" title="Staff Ranker" subtitle="Staff performance ranking with reliability and quality scores"
            sectionData={PageSectionRegistry['T23']}
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
        <PageTemplate pageId="T19" title="Client Portfolio" subtitle="Client case portfolio with revenue and visit analytics"
            sectionData={PageSectionRegistry['T19']}
        />
    );
}

// --- Extracted from service-review.tsx ---
// Re-export from identity file: T21-ServiceReview.tsx
// removed broken export: export { default } from './T21-ServiceReview';


// --- Merged from T21-ServiceReview.tsx ---
export function ServiceReview() {
    return (
        <PageTemplate pageId="T21" title="Service Review" subtitle="Service quality reviews and improvement tracking"
            sectionData={PageSectionRegistry['T21']}
        />
    );
}

// --- Extracted from surveys.tsx ---
// Re-export from identity file: T22-SurveyManager.tsx
// removed broken export: export { default } from './T22-SurveyManager';


// --- Merged from T22-SurveyManager.tsx ---
export function SurveyManager() {
    return (
        <PageTemplate pageId="T22" title="Survey Manager" subtitle="Create, distribute and analyze satisfaction surveys"
            sectionData={PageSectionRegistry['T22']}
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
            title="🎓 Training Academy"
            subtitle="Courses, certifications & staff development tracking"
            actionPageId="manager.training-academy"
            sectionData={PageSectionRegistry['H29']}
        />
    );
}
