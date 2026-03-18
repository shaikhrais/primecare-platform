import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { AdminRegistry } from 'prime-care-shared';
import { PageSectionRegistry, TEXT_VARS } from '../sections';
export { PageSectionRegistry, TEXT_VARS };

// --- Merged from error.tsx ---

// --- Merged from NotFound.tsx ---
export function NotFound() {
    return (
        <PageTemplate 
            pageId="PGE-NotFound" 
            
            sectionData={PageSectionRegistry['NotFound']}
        />
    );
}

// --- Merged from ServerError.tsx ---
export function ServerError() {
    return (
        <PageTemplate 
            pageId="PGE-ServerError" 
            
            sectionData={PageSectionRegistry['ServerError']}
        />
    );
}

// --- Merged from Unauthorized.tsx ---
export function Unauthorized() {
    return (
        <PageTemplate 
            pageId="PGE-Unauthorized" 
            
            sectionData={PageSectionRegistry['Unauthorized']}
        />
    );
}



// --- Merged from messaging.tsx ---

export function MessagingPortal() {
    return (
        <PageTemplate 
            pageId="PGE-MessagingPortal" 
            
            sectionData={PageSectionRegistry['MessagingPortal']}
        />
    );
}



// --- Merged from pages.tsx ---

// --- Merged from DevPreview.tsx ---
export function DevPreview() {
    return (
        <PageTemplate 
            pageId="PGE-DevPreview" 
            
            sectionData={PageSectionRegistry['DevPreview']}
        />
    );
}

// --- Merged from MarketingShowcase.tsx ---
export function MarketingShowcase() {
    return (
        <PageTemplate 
            pageId="PGE-MarketingShowcase" 
            
            sectionData={PageSectionRegistry['MarketingShowcase']}
        />
    );
}

// --- Merged from RoleDashboardPlaceholder.tsx ---
export function RoleDashboardPlaceholder() {
    return (
        <PageTemplate 
            pageId="PGE-RoleDashboardPlaceholder" 
            
            sectionData={PageSectionRegistry['RoleDashboardPlaceholder']}
        />
    );
}



// --- Merged from PageSectionRegistry.ts ---


export type TableColumn = any;

// Inherited from admission.tsx
const admissionSteps = [
    { icon: '📋', title: TEXT_VARS.V_K05IRRH9H, subtitle: TEXT_VARS.V_YCBTQC1Q8 },
    { icon: '👤', title: TEXT_VARS.V_2KI0AHXHR, subtitle: TEXT_VARS.V_6C83RFMH9 },
    { icon: '🏥', title: TEXT_VARS.V_EML3SLFQ9, subtitle: TEXT_VARS.V_RAGY0DYQH },
    { icon: '📊', title: TEXT_VARS.V_G50Q29MIV, subtitle: TEXT_VARS.V_CCIV5JJ8X },
    { icon: '📝', title: TEXT_VARS.V_XVS05FWGP, subtitle: TEXT_VARS.V_35AXCVDB7 },
    { icon: '✅', title: TEXT_VARS.V_4A523TDXD, subtitle: TEXT_VARS.V_HLNAIERJ5 },
];

// Inherited from ai.tsx
const aiModules = [
    { icon: '🔮', title: TEXT_VARS.V_286T3KZD3, subtitle: TEXT_VARS.V_WJS3530VA },
    { icon: '💬', title: TEXT_VARS.V_5Q7ERM1SV, subtitle: TEXT_VARS.V_ZPEN5KJ1K },
    { icon: '🎯', title: TEXT_VARS.V_IGN7ZX6LF, subtitle: TEXT_VARS.V_MC4YLTXX0 },
    { icon: '⚠️', title: TEXT_VARS.V_HS9JDDGSW, subtitle: TEXT_VARS.V_KQG5719H2 },
];

// Inherited from ai.tsx
const churnClients = [
    { client: '🔴 Margaret Chen', riskScore: '87%', factors: 'Missed 3 visits, satisfaction ↓', days: 14, action: 'Call scheduled' },
    { client: '🟠 Robert Williams', riskScore: '72%', factors: 'Auth exhausting (92%)', days: 21, action: 'Renewal pending' },
    { client: '🟡 Susan Park', riskScore: '58%', factors: 'PSW turnover (3 changes)', days: 45, action: 'Assign stable PSW' },
    { client: '🟡 James Brown', riskScore: '52%', factors: 'Missed medication 2x', days: 30, action: 'RN follow-up' },
    { client: '🟢 Helen Taylor', riskScore: '23%', factors: 'Stable – no flags', days: 90, action: 'Monitor' },
];

// Inherited from ai.tsx
const churnCols: TableColumn[] = [
    { key: 'client', label: 'Client' }, { key: 'riskScore', label: 'Risk' },
    { key: 'factors', label: 'Contributing Factors' }, { key: 'days', label: 'Days Active' },
    { key: 'action', label: 'Recommended Action' },
];

// Inherited from ai.tsx
const optimizationSuggestions = [
    { icon: '🗺️', title: TEXT_VARS.V_OBJ51H736, subtitle: TEXT_VARS.V_7AHU3UAJS },
    { icon: '⏰', title: TEXT_VARS.V_5E4JAYGR2, subtitle: TEXT_VARS.V_XDLT7RQPZ },
    { icon: '📍', title: TEXT_VARS.V_M4IN5RNVF, subtitle: TEXT_VARS.V_E4VU9LXAT },
    { icon: '✅', title: TEXT_VARS.V_IQPDXL9EY, subtitle: TEXT_VARS.V_U3CWM78BA },
];

// Inherited from ai.tsx
const sentimentFeed = [
    { icon: '😊', title: TEXT_VARS.V_VZ6LUW744, time: 'Today', level: 'success' as const },
    { icon: '😐', title: TEXT_VARS.V_BDLE71JRA, time: 'Yesterday', level: 'info' as const },
    { icon: '😟', title: TEXT_VARS.V_32KHCNUGP, time: '2 days ago', level: 'warning' as const },
    { icon: '😠', title: TEXT_VARS.V_JU4STPPM2, time: '3 days ago', level: 'danger' as const },
    { icon: '😊', title: TEXT_VARS.V_2FUC3Y3OM, time: '4 days ago', level: 'success' as const },
];

// Inherited from audits.tsx
const auditRows = [
    { time: '14:23:15', user: 'admin@primecare.ca', action: 'UPDATE', resource: 'User.PSW-045', details: 'role changed', ip: '198.51.100.23' },
    { time: '14:20:08', user: 'system', action: 'PURGE', resource: 'Session.batch', details: '23 expired sessions', ip: 'Internal' },
    { time: '13:55:42', user: 'sarah.mgr@primecare.ca', action: 'CREATE', resource: 'Visit.V-4821', details: 'New visit', ip: '203.0.113.42' },
    { time: '12:30:00', user: 'cron:compliance', action: 'SCAN', resource: 'Credentials.*', details: '77 scanned, 2 flags', ip: 'Internal' },
    { time: '11:15:33', user: 'admin@primecare.ca', action: 'EXPORT', resource: 'Report.payroll', details: 'PDF exported', ip: '198.51.100.23' },
];

// Inherited from audits.tsx
const cols: TableColumn[] = [
    { key: 'time', label: 'Time' }, { key: 'user', label: 'User' },
    { key: 'action', label: 'Action' }, { key: 'resource', label: 'Resource' },
    { key: 'details', label: 'Details' }, { key: 'ip', label: 'IP' },
];

// Inherited from authorizations.tsx
const authRows = [
    { client: 'Margaret Chen', payer: 'OHIP', service: 'PSW Home Care', approved: '120 hrs', used: '98 hrs (82%)', expires: 'Apr 30', status: '⚠️ Near Limit' },
    { client: 'Robert Williams', payer: 'WSIB', service: 'RN Wound Care', approved: '40 hrs', used: '12 hrs (30%)', expires: 'Jun 15', status: '✅ Active' },
    { client: 'Susan Park', payer: 'Private', service: 'PSW Respite', approved: '60 hrs', used: '55 hrs (92%)', expires: 'Mar 31', status: '🔴 Critical' },
    { client: 'James Brown', payer: 'OHIP', service: 'OT Assessment', approved: '8 hrs', used: '6 hrs (75%)', expires: 'May 20', status: '✅ Active' },
    { client: 'Helen Taylor', payer: 'CCAC', service: 'PSW Personal Care', approved: '200 hrs', used: '145 hrs (73%)', expires: 'Jul 31', status: '✅ Active' },
];

// Inherited from authorizations.tsx
const alertFeed = [
    { icon: '🔴', title: TEXT_VARS.V_DHZDXEOVZ, time: 'Urgent', level: 'danger' as const },
    { icon: '🟠', title: TEXT_VARS.V_XJOT1DY8K, time: '2 hrs ago', level: 'warning' as const },
    { icon: '🟡', title: TEXT_VARS.V_47GOXLYLB, time: '1 day ago', level: 'warning' as const },
    { icon: '🟢', title: TEXT_VARS.V_9U0P0TEFY, time: '2 days ago', level: 'success' as const },
];

// Inherited from automation.tsx
const automations = [
    { name: '🔄 Compliance Sweep', trigger: 'Cron: Daily 06:00', runs: 365, lastRun: 'Today 06:00', status: '✅ Active' },
    { name: '📧 Training Reminders', trigger: 'Cron: Daily 08:00', runs: 365, lastRun: 'Today 08:00', status: '✅ Active' },
    { name: '⏰ Auth Exhaustion Alert', trigger: 'Cron: M/W/F 07:00', runs: 156, lastRun: 'Today 07:00', status: '✅ Active' },
    { name: '📋 Shift Auto-Assign', trigger: 'Event: New Booking', runs: 2847, lastRun: '14:23', status: '✅ Active' },
    { name: '🔔 Visit Reminder SMS', trigger: 'Event: 1hr before visit', runs: 12450, lastRun: '14:15', status: '✅ Active' },
    { name: '📊 Weekly Report Gen', trigger: 'Cron: Mon 09:00', runs: 52, lastRun: 'Mar 11', status: '✅ Active' },
];

// Inherited from booking-requests.tsx
const bookings = [
    { id: 'BK-1205', client: 'Margaret Chen', service: 'PSW Home Care', requested: 'Mar 16', preferred: 'Mar 18 AM', status: '⏳ Pending' },
    { id: 'BK-1204', client: 'Robert Williams', service: 'RN Wound Care', requested: 'Mar 15', preferred: 'Mar 17 PM', status: '✅ Confirmed' },
    { id: 'BK-1203', client: 'Susan Park', service: 'Respite Care', requested: 'Mar 14', preferred: 'Mar 20 All Day', status: '✅ Assigned' },
    { id: 'BK-1202', client: 'James Brown', service: 'OT Assessment', requested: 'Mar 13', preferred: 'ASAP', status: '❌ Cancelled' },
];

// Inherited from claims.tsx
const claims = [
    { id: 'CLM-4821', client: 'Margaret Chen', payer: 'OHIP', amount: '$2,450', submitted: 'Mar 14', status: '⏳ Pending' },
    { id: 'CLM-4820', client: 'Robert Williams', payer: 'WSIB', amount: '$890', submitted: 'Mar 13', status: '✅ Paid' },
    { id: 'CLM-4819', client: 'Susan Park', payer: 'Private', amount: '$1,200', submitted: 'Mar 12', status: '✅ Paid' },
    { id: 'CLM-4818', client: 'James Brown', payer: 'OHIP', amount: '$3,100', submitted: 'Mar 11', status: '❌ Denied' },
    { id: 'CLM-4817', client: 'Helen Taylor', payer: 'CCAC', amount: '$4,500', submitted: 'Mar 10', status: '✅ Paid' },
];

// Inherited from claims.tsx
const cols_1: TableColumn[] = [
    { key: 'id', label: 'Claim ID' }, { key: 'client', label: 'Client' },
    { key: 'payer', label: 'Payer' }, { key: 'amount', label: 'Amount' },
    { key: 'submitted', label: 'Submitted' }, { key: 'status', label: 'Status' },
];

// Inherited from claims.tsx
const eraRows = [
    { eraId: 'ERA-0215', payer: 'OHIP', claimCount: 12, amount: '$14,500', received: 'Mar 15', status: '✅ Reconciled' },
    { eraId: 'ERA-0214', payer: 'WSIB', claimCount: 4, amount: '$3,200', received: 'Mar 14', status: '✅ Reconciled' },
    { eraId: 'ERA-0213', payer: 'CCAC', claimCount: 8, amount: '$9,800', received: 'Mar 12', status: '⚠️ Partial' },
    { eraId: 'ERA-0212', payer: 'OHIP', claimCount: 15, amount: '$18,200', received: 'Mar 10', status: '✅ Reconciled' },
];

// Inherited from claims.tsx
const cols_2: TableColumn[] = [
    { key: 'eraId', label: 'ERA ID' }, { key: 'payer', label: 'Payer' },
    { key: 'claimCount', label: 'Claims' }, { key: 'amount', label: 'Amount' },
    { key: 'received', label: 'Received' }, { key: 'status', label: 'Status' },
];

// Inherited from clinical-assistant.tsx
const clinicalModules = [
    { icon: '🩺', title: TEXT_VARS.V_EUGYHNDKD, subtitle: TEXT_VARS.V_WE0IJY8HC },
    { icon: '💊', title: TEXT_VARS.V_HBIBZQAQL, subtitle: TEXT_VARS.V_AJBXNBWV5 },
    { icon: '📋', title: TEXT_VARS.V_0RPAC1NP2, subtitle: TEXT_VARS.V_JDFR0OUHK },
    { icon: '🔬', title: TEXT_VARS.V_KTQEXCJHA, subtitle: TEXT_VARS.V_GDEK15132 },
    { icon: '📊', title: TEXT_VARS.V_4KGSR77YP, subtitle: TEXT_VARS.V_D83QQQE4V },
    { icon: '🤖', title: TEXT_VARS.V_EK2820WA0, subtitle: TEXT_VARS.V_U2E9YCVDN },
];

// Inherited from communications.tsx
const smsLogs = [
    { to: '+1 (416) 555-0123', template: 'Visit Reminder', sent: '14:15', status: '✅ Delivered', cost: '$0.015' },
    { to: '+1 (647) 555-0456', template: 'Shift Confirmation', sent: '13:45', status: '✅ Delivered', cost: '$0.015' },
    { to: '+1 (905) 555-0789', template: 'Schedule Change', sent: '12:30', status: '⏳ Pending', cost: '$0.015' },
    { to: '+1 (416) 555-0321', template: 'Auth Exhaustion Alert', sent: '11:00', status: '❌ Failed', cost: '$0.00' },
];

// Inherited from consent.tsx
const consents = [
    { client: 'Margaret Chen', type: 'General Consent', signed: 'Jan 15, 2026', expires: 'Jan 15, 2027', status: '✅ Active' },
    { client: 'Robert Williams', type: 'Telehealth Consent', signed: 'Feb 1, 2026', expires: 'Feb 1, 2027', status: '✅ Active' },
    { client: 'Susan Park', type: 'Medication Admin', signed: 'Dec 10, 2025', expires: 'Dec 10, 2026', status: '✅ Active' },
    { client: 'James Brown', type: 'Photography/Video', signed: 'Nov 5, 2025', expires: 'Nov 5, 2026', status: '✅ Active' },
    { client: 'Helen Taylor', type: 'General Consent', signed: 'Mar 1, 2025', expires: 'Mar 1, 2026', status: '🔴 Expired' },
];

// Inherited from consent.tsx
const templates = [
    { icon: '📋', title: TEXT_VARS.V_4Z0HZDZIM, subtitle: TEXT_VARS.V_I278B5S5B },
    { icon: '📱', title: TEXT_VARS.V_QJJFYQAWV, subtitle: TEXT_VARS.V_SQMR504LE },
    { icon: '💊', title: TEXT_VARS.V_7RHBKXU22, subtitle: TEXT_VARS.V_468TZXOO2 },
    { icon: '📸', title: TEXT_VARS.V_F6AB68TFA, subtitle: TEXT_VARS.V_JVQELR06H },
    { icon: '🔬', title: TEXT_VARS.V_7PNS0Z01B, subtitle: TEXT_VARS.V_SPQ4IPEU0 },
    { icon: '📊', title: TEXT_VARS.V_Y9WRNCZ80, subtitle: TEXT_VARS.V_ZRJB6H8GT },
];

// Inherited from content.tsx
const blogPosts = [
    { title: TEXT_VARS.V_IAM5116EX, date: 'Mar 12, 2026', status: '✅ Published', views: 1240 },
    { title: TEXT_VARS.V_GISG88UQJ, date: 'Mar 8, 2026', status: '✅ Published', views: 890 },
    { title: TEXT_VARS.V_9QJEJ5NI9, date: 'Mar 5, 2026', status: '📝 Draft', views: 0 },
];

// Inherited from content.tsx
const faqItems = [
    { question: 'How do I reset my password?', category: 'Account', status: '✅ Active', helpfulness: '92%' },
    { question: 'What certifications does PrimeCare require?', category: 'Compliance', status: '✅ Active', helpfulness: '88%' },
    { question: 'How does the scheduling system work?', category: 'Operations', status: '✅ Active', helpfulness: '95%' },
];

// Inherited from content.tsx
const blogCols: TableColumn[] = [
    { key: 'title', label: 'Title' }, { key: 'date', label: 'Date' },
    { key: 'status', label: 'Status' }, { key: 'views', label: 'Views' },
];

// Inherited from content.tsx
const faqCols: TableColumn[] = [
    { key: 'question', label: 'Question' }, { key: 'category', label: 'Category' },
    { key: 'status', label: 'Status' }, { key: 'helpfulness', label: 'Helpfulness' },
];

// Inherited from cron.tsx
const cronJobs = [
    { id: 'compliance-sweep', name: '🔍 Compliance Sweep', description: 'Scans all PSW credentials for expired certifications', schedule: 'Daily @ 06:00', lastRun: '2026-03-09 06:00', status: '✅ Healthy', duration: '12s' },
    { id: 'training-reminders', name: '📚 Training Reminders', description: 'Sends reminder notifications for overdue modules', schedule: 'Daily @ 08:00', lastRun: '2026-03-09 08:00', status: '✅ Healthy', duration: '4s' },
    { id: 'auth-exhaustion', name: '⏳ Auth Exhaustion Check', description: 'Checks clients near 80%+ utilization of hours', schedule: 'Mon/Wed/Fri @ 07:00', lastRun: '2026-03-07 07:00', status: '✅ Healthy', duration: '8s' },
    { id: 'inventory-reorder', name: '📦 Inventory Reorder', description: 'Generates PO suggestions when stock is low', schedule: 'Weekly @ Mon 09:00', lastRun: '2026-03-03 09:00', status: '⚠️ Warning', duration: '15s' },
];

// Inherited from cron.tsx
const jobCols: TableColumn[] = [
    { key: 'name', label: 'Job' }, { key: 'schedule', label: 'Schedule' },
    { key: 'lastRun', label: 'Last Run' }, { key: 'status', label: 'Status' },
    { key: 'duration', label: 'Duration' },
];

// Inherited from customers.tsx
const customers = [
    { name: 'Margaret Chen', age: 78, service: 'PSW Home Care', visits: '3x/week', status: '✅ Active', since: 'Jan 2024' },
    { name: 'Robert Williams', age: 82, service: 'RN Wound Care', visits: '2x/week', status: '✅ Active', since: 'Mar 2025' },
    { name: 'Susan Park', age: 71, service: 'Respite Care', visits: '1x/week', status: '✅ Active', since: 'Sep 2025' },
    { name: 'James Brown', age: 85, service: 'PT + OT', visits: '2x/week', status: '⏳ Intake', since: 'Mar 2026' },
    { name: 'Helen Taylor', age: 89, service: 'PSW Personal Care', visits: 'Daily', status: '✅ Active', since: 'Jun 2023' },
];

// Inherited from dashboard.tsx
const quickActions = [
    { icon: '📅', title: TEXT_VARS.V_WU4ZGQJ1S, subtitle: "Today's shifts" },
    { icon: '👥', title: TEXT_VARS.V_UBVZVO8JD, subtitle: TEXT_VARS.V_6E0RLYSGU },
    { icon: '🏥', title: TEXT_VARS.V_U7Q1ZOJKK, subtitle: TEXT_VARS.V_61CK2GRUQ },
    { icon: '💰', title: TEXT_VARS.V_4EYI4QMK9, subtitle: TEXT_VARS.V_H0HTRFPDI },
    { icon: '📋', title: TEXT_VARS.V_9XAOHVH7N, subtitle: TEXT_VARS.V_IQNZXBJ6W },
    { icon: '🤖', title: TEXT_VARS.V_TID8B1PMQ, subtitle: TEXT_VARS.V_TJL2S0JU5 },
];

// Inherited from dashboard.tsx
const registryModules = [
    { icon: '📋', title: TEXT_VARS.V_T8ALJ0BB6, subtitle: TEXT_VARS.V_XQOH4D4PD },
    { icon: '🔗', title: TEXT_VARS.V_CM1YED4VD, subtitle: TEXT_VARS.V_VCZ2JAKLQ },
    { icon: '📊', title: TEXT_VARS.V_HDF9SQGB7, subtitle: TEXT_VARS.V_HKU6LVSB6 },
    { icon: '🔑', title: TEXT_VARS.V_7ZGYGBCYW, subtitle: TEXT_VARS.V_ABHMTRYNI },
    { icon: '📡', title: TEXT_VARS.V_09GSIWQ17, subtitle: TEXT_VARS.V_AVXRB75OT },
    { icon: '🎨', title: TEXT_VARS.V_PQXQBRFPG, subtitle: TEXT_VARS.V_FOWGG6XNP },
];

// Inherited from documents.tsx
const documents = [
    { provider: 'Kevin Chen (PSW)', docType: 'CPR Certification', status: '✅ Approved', uploaded: 'Mar 14', expires: 'Mar 2028' },
    { provider: 'Sarah Williams (RN)', docType: 'RN License', status: '✅ Approved', uploaded: 'Feb 28', expires: 'Dec 2026' },
    { provider: 'Maria Santos (PSW)', docType: 'VSS (Vulnerable Sector)', status: '⏳ Pending Review', uploaded: 'Mar 15', expires: 'Mar 2029' },
    { provider: 'James Park (PSW)', docType: 'First Aid Certificate', status: '✅ Approved', uploaded: 'Jan 20', expires: 'Jan 2029' },
    { provider: 'Lisa Brown (PSW)', docType: 'TB Test Results', status: '❌ Rejected', uploaded: 'Mar 10', expires: '—' },
];

// Inherited from earnings.tsx
const earningsRows = [
    { invoice: 'INV-2024-042', client: 'Margaret Chen', service: 'PSW Home Care', hours: '38.5', amount: '$943.25', status: '✅ Paid', date: 'Mar 15' },
    { invoice: 'INV-2024-041', client: 'Robert Williams', service: 'RN Wound Care', hours: '4.0', amount: '$168.00', status: '✅ Paid', date: 'Mar 14' },
    { invoice: 'INV-2024-040', client: 'Helen Taylor', service: 'PSW Personal Care', hours: '20.0', amount: '$490.00', status: '⏳ Pending', date: 'Mar 13' },
    { invoice: 'INV-2024-039', client: 'James Brown', service: 'Respite Care', hours: '12.0', amount: '$312.00', status: '⏳ Pending', date: 'Mar 12' },
];

// Inherited from erp.tsx
const erpModules = [
    { icon: '📦', title: TEXT_VARS.V_RFETQZ9QJ, subtitle: TEXT_VARS.V_AFO0AWXAO },
    { icon: '🛒', title: TEXT_VARS.V_506QINA9Q, subtitle: TEXT_VARS.V_TYU5PQWLA },
    { icon: '🏭', title: TEXT_VARS.V_US0CN6JV9, subtitle: TEXT_VARS.V_B9GTRAGS5 },
    { icon: '📊', title: TEXT_VARS.V_1AZBKR3J3, subtitle: TEXT_VARS.V_77FK3OVPL },
    { icon: '🔍', title: TEXT_VARS.V_LKCQJNG59, subtitle: TEXT_VARS.V_C3RKRODS4 },
    { icon: '💰', title: TEXT_VARS.V_JP2K4E1OU, subtitle: TEXT_VARS.V_U286XNVXY },
];

// Inherited from evv.tsx
const exceptions = [
    { date: 'Mar 16', psw: 'Kevin Chen', client: 'Robert Williams', type: 'GPS Mismatch', detail: '50m outside zone', status: '⏳ Review' },
    { date: 'Mar 16', psw: 'Maria Santos', client: 'James Brown', type: 'Missing Clock-In', detail: 'Visit started, no EVV', status: '⚠️ Open' },
    { date: 'Mar 15', psw: 'Lisa Park', client: 'Helen Taylor', type: 'Duration Mismatch', detail: '3.5h vs 2h authorized', status: '✅ Resolved' },
];

// Inherited from reconciliation.tsx
const reconciliationRows = [
    { id: 'BF-001', bank: 'TD Canada Trust', description: 'OHIP Deposit — Mar Billing', amount: '$12,450.00', match: '✅ Auto-matched (Invoice INV-2024-038)', confidence: '99%' },
    { id: 'BF-002', bank: 'TD Canada Trust', description: 'WSIB Payout', amount: '$3,200.00', match: '⚠️ Fuzzy match (Payroll PR-042)', confidence: '87%' },
    { id: 'BF-003', bank: 'TD Canada Trust', description: 'Office Supplies — Staples', amount: '-$142.50', match: '❌ No match found', confidence: '—' },
];

// Inherited from incidents.tsx
const incidents = [
    { id: 'INC-042', date: 'Mar 15', type: 'Fall', client: 'Helen Taylor', severity: '🟡 Medium', status: '⏳ Open' },
    { id: 'INC-041', date: 'Mar 13', type: 'Medication Error', client: 'Margaret Chen', severity: '🔴 High', status: '🔍 Investigating' },
    { id: 'INC-040', date: 'Mar 10', type: 'Near Miss', client: 'Robert Williams', severity: '🟢 Low', status: '✅ Closed' },
    { id: 'INC-039', date: 'Mar 7', type: 'Workplace Injury', client: '—', severity: '🟡 Medium', status: '✅ Closed' },
];

// Inherited from leads.tsx
const leads = [
    { name: 'John Smith', source: 'Website', service: 'PSW Home Care', stage: '🟢 Qualified', assigned: 'Sarah Mgr', age: '3 days' },
    { name: 'Mary Johnson', source: 'Referral (Dr. Wong)', service: 'RN Wound Care', stage: '🟡 Contact Made', assigned: 'Sarah Mgr', age: '1 day' },
    { name: 'David Lee', source: 'Call-In', service: 'Respite Care', stage: '⚪ New', assigned: 'Unassigned', age: '< 1 hr' },
    { name: 'Patricia Davis', source: 'Website', service: 'OT Assessment', stage: '🔵 Proposal Sent', assigned: 'Mike Coord', age: '5 days' },
];

// Inherited from ops.tsx
const opsModules = [
    { icon: '📋', title: TEXT_VARS.V_WSI5PQQRZ, subtitle: TEXT_VARS.V_4UDWJ1TBD },
    { icon: '🚗', title: TEXT_VARS.V_G4TMJTMUZ, subtitle: TEXT_VARS.V_QJE9PQB38 },
    { icon: '📊', title: TEXT_VARS.V_6EAHLN3C1, subtitle: TEXT_VARS.V_VHVUHQAAW },
    { icon: '⚡', title: TEXT_VARS.V_J1P2ZSYQS, subtitle: TEXT_VARS.V_MWHD5XOHJ },
    { icon: '🔄', title: TEXT_VARS.V_4ULD0IES4, subtitle: TEXT_VARS.V_1LQE3KPPZ },
    { icon: '📈', title: TEXT_VARS.V_QD4XW88NR, subtitle: TEXT_VARS.V_U7B8194TA },
];

// Inherited from payroll.tsx
const payrollRuns = [
    { period: 'Week 11 (Mar 10-16)', employees: 82, grossPay: '$147,250', deductions: '$38,285', netPay: '$108,965', status: 'Processing' },
    { period: 'Week 10 (Mar 3-9)', employees: 81, grossPay: '$144,800', deductions: '$37,648', netPay: '$107,152', status: 'Paid' },
    { period: 'Week 9 (Feb 24-Mar 2)', employees: 80, grossPay: '$143,200', deductions: '$37,232', netPay: '$105,968', status: 'Paid' },
];

// Inherited from payroll.tsx
const payrollCols: TableColumn[] = [
    { key: 'period', label: 'Period' }, { key: 'employees', label: 'Employees' },
    { key: 'grossPay', label: 'Gross Pay' }, { key: 'deductions', label: 'Deductions' },
    { key: 'netPay', label: 'Net Pay' }, { key: 'status', label: 'Status' },
];

// Inherited from pharmacy.tsx
const prescriptions = [
    { medication: '💊 Metformin 500mg', patient: 'Margaret Chen', frequency: 'BID (2x daily)', status: 'Active', nextDose: '18:00' },
    { medication: '💊 Lisinopril 10mg', patient: 'Robert Williams', frequency: 'QD (1x daily)', status: 'Active', nextDose: '08:00' },
    { medication: '💊 Warfarin 5mg', patient: 'Susan Park', frequency: 'QD (1x daily)', status: 'Renewed', nextDose: '20:00' },
    { medication: '💊 Furosemide 40mg', patient: 'James Brown', frequency: 'BID (2x daily)', status: 'Active', nextDose: '12:00' },
    { medication: '💊 Donepezil 10mg', patient: 'Helen Taylor', frequency: 'QHS (at bedtime)', status: 'Active', nextDose: '21:00' },
    { medication: '💉 Insulin Glargine 20u', patient: 'Margaret Chen', frequency: 'QD (1x daily)', status: 'Active', nextDose: '22:00' },
];

// Inherited from pharmacy.tsx
const medCols: TableColumn[] = [
    { key: 'medication', label: 'Medication' }, { key: 'patient', label: 'Patient' },
    { key: 'frequency', label: 'Frequency' }, { key: 'status', label: 'Status' },
    { key: 'nextDose', label: 'Next Dose' },
];

// Inherited from rcm.tsx
const rcmModules = [
    { icon: '📋', title: TEXT_VARS.V_MU8SNRPNU, subtitle: TEXT_VARS.V_X0UDW2MJR },
    { icon: '💳', title: TEXT_VARS.V_5GASMFWU5, subtitle: TEXT_VARS.V_PPWWBWGXY },
    { icon: '🔄', title: TEXT_VARS.V_ZPMDBCC7W, subtitle: TEXT_VARS.V_WQMHR9GS8 },
    { icon: '📊', title: TEXT_VARS.V_62X6UPFYZ, subtitle: TEXT_VARS.V_F0AAVTLA1 },
    { icon: '💰', title: TEXT_VARS.V_2GD284I5J, subtitle: TEXT_VARS.V_1ZTOOHL1I },
    { icon: '📈', title: TEXT_VARS.V_0SY4J9H0W, subtitle: TEXT_VARS.V_WLXHCNN98 },
];

// Inherited from reference-data.tsx
const refDataModules = [
    { icon: '🗂️', title: TEXT_VARS.V_4HZ7RL5ZY, subtitle: TEXT_VARS.V_0Q8ICJD1G },
    { icon: '📋', title: TEXT_VARS.V_OW9D81BRT, subtitle: TEXT_VARS.V_QFRH0X56G },
    { icon: '🏥', title: TEXT_VARS.V_TRIC7M370, subtitle: TEXT_VARS.V_1I2OJV03D },
    { icon: '💊', title: TEXT_VARS.V_PMLTHIDIU, subtitle: TEXT_VARS.V_QUTVG020H },
    { icon: '📍', title: TEXT_VARS.V_ZEYBTQ5M6, subtitle: TEXT_VARS.V_9NWC4TNFV },
    { icon: '📊', title: TEXT_VARS.V_8W40M6XB4, subtitle: TEXT_VARS.V_BADRUSBVO },
];

// Inherited from referrals.tsx
const referrals = [
    { id: 'REF-201', source: 'Dr. Smith (Family MD)', client: 'New — Margaret Chen', service: 'PSW Home Care', received: 'Mar 14', status: '⏳ Intake Pending' },
    { id: 'REF-200', source: 'CCAC Coordinator', client: 'New — John Doe', service: 'RN Wound Care', received: 'Mar 12', status: '✅ Accepted' },
    { id: 'REF-199', source: 'Hospital Discharge', client: 'Transfer — Jane Roe', service: 'Rehab OT', received: 'Mar 10', status: '✅ Active' },
    { id: 'REF-198', source: 'Self-Referral', client: 'New — Bob Lee', service: 'Respite Care', received: 'Mar 8', status: '❌ Waitlisted' },
];

// Inherited from reports.tsx
const reportModules = [
    { icon: '📊', title: TEXT_VARS.V_U4EU26NS5, subtitle: TEXT_VARS.V_00DYGZC9O },
    { icon: '👥', title: TEXT_VARS.V_7TSB9RVIQ, subtitle: TEXT_VARS.V_1IHT3RD32 },
    { icon: '🏥', title: TEXT_VARS.V_HLJJPUJXC, subtitle: TEXT_VARS.V_BQSY1WU9Y },
    { icon: '📋', title: TEXT_VARS.V_3ERIW2X2K, subtitle: TEXT_VARS.V_1KHWU1K0P },
    { icon: '📈', title: TEXT_VARS.V_68G7XO08Z, subtitle: TEXT_VARS.V_2BWMAHXJO },
    { icon: '🔍', title: TEXT_VARS.V_I42IAN6I8, subtitle: TEXT_VARS.V_PMAEKDMXK },
];

// Inherited from role-editor.tsx
const roles = [
    { name: '🔑 Super Admin', users: 1, permissions: 'Full Access', scope: 'Global', status: '🔒 System' },
    { name: '👤 Admin', users: 2, permissions: '95% Access', scope: 'Tenant', status: '✅ Active' },
    { name: '📊 Manager', users: 5, permissions: 'Team + Reports', scope: 'Team', status: '✅ Active' },
    { name: '🏥 PSW', users: 82, permissions: 'Basic + EVV + Docs', scope: 'Self + Clients', status: '✅ Active' },
    { name: '🩺 RN', users: 4, permissions: 'Clinical + Meds', scope: 'Self + Clients', status: '✅ Active' },
    { name: '💰 Finance', users: 2, permissions: 'Billing + Reports', scope: 'Financial', status: '✅ Active' },
];

// Inherited from security.tsx
const recentJournals = [
    { date: 'Mar 16', ref: 'JE-2451', account: 'Payroll Expense', debit: '$147,250', credit: '—', balance: '$847,250' },
    { date: 'Mar 16', ref: 'JE-2451', account: 'Cash — Operating', debit: '—', credit: '$147,250', balance: '$1,232,400' },
    { date: 'Mar 15', ref: 'JE-2450', account: 'Accounts Receivable', debit: '$8,420', credit: '—', balance: '$156,840' },
    { date: 'Mar 14', ref: 'JE-2449', account: 'OHIP Claims Receivable', debit: '$23,100', credit: '—', balance: '$89,400' },
];

// Inherited from security.tsx
const journalCols: TableColumn[] = [
    { key: 'date', label: 'Date' }, { key: 'ref', label: 'Ref' },
    { key: 'account', label: 'Account' }, { key: 'debit', label: 'Debit' },
    { key: 'credit', label: 'Credit' }, { key: 'balance', label: 'Balance' },
];

// Inherited from security.tsx
const auditEntries = [
    { timestamp: '2026-03-16 16:42', actor: 'admin@primecare.ca', action: 'UPDATE', resource: 'User/PSW-045', details: 'Role changed psw → rn', severity: '🟠 HIGH', ip: '198.51.100.23' },
    { timestamp: '2026-03-16 16:38', actor: 'sarah.mgr@primecare.ca', action: 'CREATE', resource: 'Visit/V-2847', details: 'New visit: Sharma → Chen', severity: 'ℹ️ INFO', ip: '203.0.113.42' },
    { timestamp: '2026-03-16 16:35', actor: 'system', action: 'DELETE', resource: 'Session/batch', details: 'Purged 23 expired sessions', severity: 'ℹ️ INFO', ip: '10.0.0.1' },
    { timestamp: '2026-03-16 16:30', actor: 'kevin.psw@primecare.ca', action: 'AUTH_FAIL', resource: 'Auth/Login', details: 'Failed login (wrong password)', severity: '⚠️ WARN', ip: '72.134.215.90' },
    { timestamp: '2026-03-16 16:25', actor: 'admin@primecare.ca', action: 'UPDATE', resource: 'Tenant/T-001', details: 'Feature flag "telehealth" enabled', severity: '🟠 HIGH', ip: '198.51.100.23' },
    { timestamp: '2026-03-16 16:20', actor: 'finance@primecare.ca', action: 'EXPORT', resource: 'Invoice/batch', details: 'Exported 47 invoices to CSV', severity: 'ℹ️ INFO', ip: '198.51.100.25' },
    { timestamp: '2026-03-16 16:15', actor: 'admin@primecare.ca', action: 'DELETE', resource: 'User/PSW-012', details: 'Deactivated user (termination)', severity: '🔴 CRIT', ip: '198.51.100.23' },
    { timestamp: '2026-03-16 16:10', actor: 'system', action: 'BACKUP', resource: 'Database/primary', details: 'Daily backup completed (245MB)', severity: 'ℹ️ INFO', ip: '10.0.0.1' },
    { timestamp: '2026-03-16 16:05', actor: 'unknown', action: 'AUTH_FAIL', resource: 'Auth/Login', details: 'Brute force: 15 attempts/60s. IP blocked.', severity: '🔴 CRIT', ip: '185.220.101.42' },
    { timestamp: '2026-03-16 16:00', actor: 'sarah.mgr@primecare.ca', action: 'UPDATE', resource: 'Schedule/W12', details: 'Modified 8 shifts for next week', severity: 'ℹ️ INFO', ip: '203.0.113.42' },
];

// Inherited from security.tsx
const auditCols: TableColumn[] = [
    { key: 'timestamp', label: 'Time' }, { key: 'actor', label: 'Actor' },
    { key: 'action', label: 'Action' }, { key: 'resource', label: 'Resource' },
    { key: 'details', label: 'Details' }, { key: 'severity', label: 'Severity' },
    { key: 'ip', label: 'IP' },
];

// Inherited from security.tsx
const securityModules = [
    { icon: '🔍', title: TEXT_VARS.V_Q7EUQ0WJ, subtitle: TEXT_VARS.V_SHED0D6NH },
    { icon: '📋', title: TEXT_VARS.V_7IYFBGXV0, subtitle: TEXT_VARS.V_627JXG7QZ },
    { icon: '🔑', title: TEXT_VARS.V_Y4ZCMEQUH, subtitle: TEXT_VARS.V_AYSGE464P },
    { icon: '🚨', title: TEXT_VARS.V_GQN69A5OY, subtitle: TEXT_VARS.V_4823HVSE9 },
];

// Inherited from security.tsx
const activityFeed = [
    { icon: '🔴', title: TEXT_VARS.V_STT0PXK4T, time: '2 min ago', level: 'danger' as const },
    { icon: '🟠', title: TEXT_VARS.V_OFWOVWAWR, time: '15 min ago', level: 'warning' as const },
    { icon: '🟢', title: TEXT_VARS.V_SJKIRG7IF, time: '1 hr ago', level: 'success' as const },
    { icon: 'ℹ️', title: TEXT_VARS.V_UK00G7XHM, time: '2 hrs ago', level: 'info' as const },
    { icon: '🟢', title: TEXT_VARS.V_QKSKWR2XR, time: '3 hrs ago', level: 'success' as const },
];

// Inherited from security.tsx
const devices = [
    { name: 'iPhone 14 Pro', user: 'Kevin Chen (PSW)', os: 'iOS 17.4', lastSeen: 'Today 14:23', status: '✅ Active', trust: 'Trusted' },
    { name: 'Samsung Galaxy S24', user: 'Maria Santos (PSW)', os: 'Android 14', lastSeen: 'Today 13:45', status: '✅ Active', trust: 'Trusted' },
    { name: 'iPad Air (5th)', user: 'Sarah Manager', os: 'iPadOS 17.4', lastSeen: 'Today 10:00', status: '✅ Active', trust: 'Trusted' },
    { name: 'Chrome — Windows', user: 'admin@primecare.ca', os: 'Win 11', lastSeen: 'Today 14:30', status: '✅ Active', trust: 'Trusted' },
    { name: 'Unknown Android', user: 'lisa.park@primecare.ca', os: 'Android 13', lastSeen: 'Mar 10', status: '⚠️ Stale', trust: 'Untrusted' },
];

// Inherited from security.tsx
const cols_5: TableColumn[] = [
    { key: 'name', label: 'Device' }, { key: 'user', label: 'User' },
    { key: 'os', label: 'OS' }, { key: 'lastSeen', label: 'Last Seen' },
    { key: 'status', label: 'Status' }, { key: 'trust', label: 'Trust' },
];

// Inherited from security.tsx
const forens = [
    { timestamp: '2026-03-16 14:23:15', actor: 'admin@primecare.ca', action: 'UPDATE', resource: 'User.PSW-045', detail: 'role: PSW → Manager', ip: '198.51.100.23' },
    { timestamp: '2026-03-16 14:20:08', actor: 'system', action: 'DELETE', resource: 'Session.expired-batch', detail: '23 sessions purged', ip: 'Internal' },
    { timestamp: '2026-03-16 13:55:42', actor: 'sarah.mgr@primecare.ca', action: 'CREATE', resource: 'Visit.V-4821', detail: 'New visit for Client Chen', ip: '203.0.113.42' },
    { timestamp: '2026-03-16 12:30:00', actor: 'cron:compliance-sweep', action: 'SCAN', resource: 'Credentials.*', detail: '77 PSW records scanned, 2 flags', ip: 'Internal' },
    { timestamp: '2026-03-16 11:15:33', actor: 'admin@primecare.ca', action: 'EXPORT', resource: 'Report.payroll-Q1', detail: 'PDF exported, 12 pages', ip: '198.51.100.23' },
];

// Inherited from security.tsx
const forensCols: TableColumn[] = [
    { key: 'timestamp', label: 'Timestamp' }, { key: 'actor', label: 'Actor' },
    { key: 'action', label: 'Action' }, { key: 'resource', label: 'Resource' },
    { key: 'detail', label: 'Detail' }, { key: 'ip', label: 'IP' },
];

// Inherited from security.tsx
const origins = [
    { origin: '✅ primecare-admin.pages.dev', type: 'Production', methods: 'GET, POST, PUT, DELETE', status: 'Active' },
    { origin: '✅ localhost:5173', type: 'Development', methods: 'GET, POST, PUT, DELETE', status: 'Active' },
    { origin: '✅ primecare-api.workers.dev', type: 'API Worker', methods: 'GET, POST', status: 'Active' },
    { origin: '⚠️ staging.primecare.ca', type: 'Staging', methods: 'GET, POST', status: 'Review' },
];

// Inherited from security.tsx
const corsCols: TableColumn[] = [
    { key: 'origin', label: 'Origin' }, { key: 'type', label: 'Environment' },
    { key: 'methods', label: 'Allowed Methods' }, { key: 'status', label: 'Status' },
];

// Inherited from security.tsx
const journalEntries = [
    { date: 'Mar 16', ref: 'JE-2451', description: 'Payroll — Week 11', debit: '$147,250.00', credit: '$147,250.00', status: 'Posted' },
    { date: 'Mar 15', ref: 'JE-2450', description: 'Client Billing — Chen, Park', debit: '$8,420.00', credit: '$8,420.00', status: 'Posted' },
    { date: 'Mar 14', ref: 'JE-2449', description: 'OHIP Claim — Batch #127', debit: '$23,100.00', credit: '$23,100.00', status: 'Pending' },
    { date: 'Mar 13', ref: 'JE-2448', description: 'Supply Purchase — MedEquip', debit: '$1,840.00', credit: '$1,840.00', status: 'Posted' },
    { date: 'Mar 12', ref: 'JE-2447', description: 'HST Remittance — Feb 2026', debit: '$12,350.00', credit: '$12,350.00', status: 'Posted' },
];

// Inherited from security.tsx
const ledgerCols: TableColumn[] = [
    { key: 'date', label: 'Date' }, { key: 'ref', label: 'Reference' },
    { key: 'description', label: 'Description' }, { key: 'debit', label: 'Debit' },
    { key: 'credit', label: 'Credit' }, { key: 'status', label: 'Status' },
];

// Inherited from security.tsx
const complianceCards = [
    { icon: '🇨🇦', title: TEXT_VARS.V_UVF4XYS1, subtitle: TEXT_VARS.V_T5MQ094SS },
    { icon: '📋', title: TEXT_VARS.V_UDBP3H4L2, subtitle: TEXT_VARS.V_S89OO6RW3 },
    { icon: '💳', title: TEXT_VARS.V_UZZD0K2F5, subtitle: TEXT_VARS.V_EPZGLAH98 },
    { icon: '🏛️', title: TEXT_VARS.V_CK9QHCVA2, subtitle: TEXT_VARS.V_XV1O9KH2P },
    { icon: '📊', title: TEXT_VARS.V_A5EZBCUYU, subtitle: TEXT_VARS.V_AXYJUQFVQ },
    { icon: '🔒', title: TEXT_VARS.V_Z1RBY2ZHH, subtitle: TEXT_VARS.V_QZFTSF9UF },
];

// Inherited from security.tsx
const roleMatrix = [
    { role: '🔑 Admin', users: 3, permissions: 60, level: 'Full Access', lastAudit: 'Mar 15' },
    { role: '👩‍⚕️ RN (Registered Nurse)', users: 8, permissions: 35, level: 'Clinical', lastAudit: 'Mar 14' },
    { role: '👤 Manager', users: 5, permissions: 42, level: 'Operations', lastAudit: 'Mar 14' },
    { role: '🏥 PSW', users: 77, permissions: 12, level: 'Field', lastAudit: 'Mar 13' },
    { role: '📊 Coordinator', users: 4, permissions: 28, level: 'Scheduling', lastAudit: 'Mar 12' },
    { role: '💰 Finance', users: 2, permissions: 18, level: 'Financial', lastAudit: 'Mar 10' },
];

// Inherited from security.tsx
const roleCols: TableColumn[] = [
    { key: 'role', label: 'Role' }, { key: 'users', label: 'Users' },
    { key: 'permissions', label: 'Permissions' }, { key: 'level', label: 'Access Level' },
    { key: 'lastAudit', label: 'Last Audit' },
];

// Inherited from security.tsx
const sessions = [
    { user: '🟢 admin@primecare.ca', role: 'Admin', device: 'Chrome / Windows', ip: '198.51.100.23', duration: '2h 15m', location: 'Toronto, ON' },
    { user: '🟢 sarah.mgr@primecare.ca', role: 'Manager', device: 'Safari / macOS', ip: '203.0.113.42', duration: '45m', location: 'North York, ON' },
    { user: '🟢 kevin.psw@primecare.ca', role: 'PSW', device: 'PrimeCare PWA / Android', ip: '72.134.215.90', duration: '1h 30m', location: 'Mississauga, ON' },
    { user: '🟡 finance@primecare.ca', role: 'Finance', device: 'Firefox / Linux', ip: '198.51.100.25', duration: '10m', location: 'Ottawa, ON' },
    { user: '🔴 unknown@test.com', role: '—', device: 'curl/7.88.1', ip: '185.220.101.42', duration: 'Blocked', location: 'TOR Exit Node' },
];

// Inherited from security.tsx
const sessionCols: TableColumn[] = [
    { key: 'user', label: 'User' }, { key: 'role', label: 'Role' },
    { key: 'device', label: 'Device' }, { key: 'ip', label: 'IP' },
    { key: 'duration', label: 'Duration' }, { key: 'location', label: 'Location' },
];

// Inherited from security.tsx
const threats = [
    { icon: '🔴', title: TEXT_VARS.V_YBQ215RNQ, time: '2 min ago', level: 'danger' as const },
    { icon: '🟠', title: TEXT_VARS.V_2NBH770YJ, time: '15 min ago', level: 'warning' as const },
    { icon: '🟡', title: TEXT_VARS.V_5IOWL26D4, time: '1 hr ago', level: 'warning' as const },
    { icon: '🟢', title: TEXT_VARS.V_5OHUC8UUV, time: '3 hrs ago', level: 'success' as const },
    { icon: '🟢', title: TEXT_VARS.V_5IVNXT9AU, time: '6 hrs ago', level: 'success' as const },
    { icon: 'ℹ️', title: TEXT_VARS.V_G0DGEFT6T, time: '12 hrs ago', level: 'info' as const },
];

// Inherited from services.tsx
const services = [
    { code: 'PSW-HC', name: '🏠 PSW Home Care', rate: '$24.50/hr', clients: 45, status: '✅ Active' },
    { code: 'RN-WC', name: '🩺 RN Wound Care', rate: '$42.00/hr', clients: 12, status: '✅ Active' },
    { code: 'PSW-RC', name: '🛋️ Respite Care', rate: '$26.00/hr', clients: 8, status: '✅ Active' },
    { code: 'OT-AS', name: '🧩 OT Assessment', rate: '$55.00/hr', clients: 5, status: '✅ Active' },
    { code: 'PT-RH', name: '💪 PT Rehab', rate: '$52.00/hr', clients: 3, status: '✅ Active' },
    { code: 'PSW-PC', name: '🫧 PSW Personal Care', rate: '$24.50/hr', clients: 38, status: '✅ Active' },
];

// Inherited from settings.tsx
const currencies = [
    { code: 'CAD 🇨🇦 (BASE)', name: 'Canadian Dollar', symbol: '$', rate: '1.0000', status: 'ACTIVE' },
    { code: 'USD 🇺🇸', name: 'US Dollar', symbol: '$', rate: '0.7412', status: 'ACTIVE' },
    { code: 'GBP 🇬🇧', name: 'British Pound', symbol: '£', rate: '0.5891', status: 'ACTIVE' },
    { code: 'EUR 🇪🇺', name: 'Euro', symbol: '€', rate: '0.6823', status: 'ACTIVE' },
    { code: 'INR 🇮🇳', name: 'Indian Rupee', symbol: '₹', rate: '61.45', status: 'INACTIVE' },
    { code: 'PHP 🇵🇭', name: 'Philippine Peso', symbol: '₱', rate: '41.28', status: 'INACTIVE' },
];

// Inherited from settings.tsx
const currencyCols: TableColumn[] = [
    { key: 'code', label: 'Currency' }, { key: 'symbol', label: 'Symbol' },
    { key: 'rate', label: 'Rate (to CAD)' }, { key: 'status', label: 'Status' },
];

// Inherited from settings.tsx
const fxTransactions = [
    { id: 'INV-2847', description: 'Invoice #INV-2847', conversion: 'USD $2,340 → CAD $3,157', rate: '1.3492', date: 'Mar 15' },
    { id: 'MED-UK', description: 'Supplier Payment — MedEquip UK', conversion: 'CAD $4,200 → GBP £2,474', rate: '0.5891', date: 'Mar 14' },
    { id: 'EU-CLIENT', description: 'Client Billing — EU Client', conversion: 'CAD $1,890 → EUR €1,290', rate: '0.6823', date: 'Mar 12' },
];

// Inherited from settings.tsx
const fxCols: TableColumn[] = [
    { key: 'description', label: 'Transaction' }, { key: 'conversion', label: 'Conversion' },
    { key: 'rate', label: 'Rate' }, { key: 'date', label: 'Date' },
];

// Inherited from telehealth.tsx
const sessionData = [
    { patient: 'Margaret Chen', type: 'Video Consult', provider: 'Dr. Smith', status: 'In-Progress', time: '14:30' },
    { patient: 'Robert Williams', type: 'RPM Review', provider: 'RN Johnson', status: 'Scheduled', time: '15:00' },
    { patient: 'Susan Park', type: 'Follow-up', provider: 'Dr. Martinez', status: 'In-Progress', time: '14:45' },
];

// Inherited from timesheet-adjustment.tsx
const adjustments = [
    { id: 'ADJ-102', psw: 'Kevin Chen', date: 'Mar 14', original: '8.0 hrs', adjusted: '8.5 hrs', reason: 'Missed clock-out — client confirmed', status: '⏳ Pending' },
    { id: 'ADJ-101', psw: 'Maria Santos', date: 'Mar 12', original: '4.0 hrs', adjusted: '3.5 hrs', reason: 'Early departure — PSW illness', status: '✅ Approved' },
    { id: 'ADJ-100', psw: 'Lisa Park', date: 'Mar 10', original: '6.0 hrs', adjusted: '6.5 hrs', reason: 'Extended care — client emergency', status: '✅ Approved' },
];

// Inherited from timesheets.tsx
const timesheets = [
    { psw: 'Kevin Chen', period: 'Mar 10-16', regular: '38.5 hrs', ot: '2.5 hrs', total: '$1,025', status: '⏳ Pending' },
    { psw: 'Maria Santos', period: 'Mar 10-16', regular: '40 hrs', ot: '0 hrs', total: '$980', status: '✅ Approved' },
    { psw: 'Lisa Park', period: 'Mar 10-16', regular: '36 hrs', ot: '4 hrs', total: '$1,040', status: '✅ Approved' },
    { psw: 'James Williams', period: 'Mar 10-16', regular: '32 hrs', ot: '0 hrs', total: '$784', status: '⏳ Pending' },
];

// Inherited from users.tsx
const users = [
    { name: 'Admin User', email: 'admin@primecare.ca', role: '🔑 Admin', status: '✅ Active', lastLogin: 'Today 14:23' },
    { name: 'Sarah Manager', email: 'sarah.mgr@primecare.ca', role: '👤 Manager', status: '✅ Active', lastLogin: 'Today 13:45' },
    { name: 'Kevin Chen', email: 'kevin.psw@primecare.ca', role: '🏥 PSW', status: '✅ Active', lastLogin: 'Today 12:30' },
    { name: 'Maria Santos', email: 'maria.psw@primecare.ca', role: '🏥 PSW', status: '✅ Active', lastLogin: 'Yesterday' },
    { name: 'Finance User', email: 'finance@primecare.ca', role: '💰 Finance', status: '✅ Active', lastLogin: 'Today 10:00' },
];

// Inherited from webhooks.tsx
const webhooks = [
    { id: 'WH-01', name: 'Slack Notifications', url: 'https://hooks.slack.com/...', events: 'visit.created, incident.*', status: '✅ Active', lastDelivery: '14:23' },
    { id: 'WH-02', name: 'Billing Sync', url: 'https://billing.example.com/hooks', events: 'claim.submitted, payment.*', status: '✅ Active', lastDelivery: '13:45' },
    { id: 'WH-03', name: 'EMR Integration', url: 'https://emr.example.com/api/events', events: 'patient.*, assessment.*', status: '⚠️ Failing', lastDelivery: 'Mar 14' },
];

// Inherited from webhooks.tsx
const deliveries = [
    { time: '14:23:15', webhook: 'Slack Notifications', event: 'visit.created', status: '✅ 200', duration: '120ms' },
    { time: '14:23:14', webhook: 'Billing Sync', event: 'claim.submitted', status: '✅ 200', duration: '340ms' },
    { time: '14:20:08', webhook: 'EMR Integration', event: 'patient.updated', status: '❌ 500', duration: '2100ms' },
    { time: '13:45:22', webhook: 'Billing Sync', event: 'payment.received', status: '✅ 200', duration: '180ms' },
    { time: '13:30:11', webhook: 'EMR Integration', event: 'assessment.completed', status: '❌ Timeout', duration: '30000ms' },
];

// Inherited from documents.tsx
const docCols: TableColumn[] = [
    { key: 'name', label: 'Document' }, { key: 'type', label: 'Type' },
    { key: 'status', label: 'Status' }, { key: 'signers', label: 'Signers' },
    { key: 'created', label: 'Created' }, { key: 'expires', label: 'Expires' },
];

// Inherited from hr.tsx
const reviews = [
    { psw: 'Priya Sharma', period: 'Q1 2026', overall: '4.8', quality: '5.0', punctuality: '4.9', communication: '4.7', status: '✅ Completed', reviewer: 'Sarah Manager', date: 'Mar 12' },
    { psw: 'David Chen', period: 'Q1 2026', overall: '4.5', quality: '4.6', punctuality: '4.8', communication: '4.3', status: '✅ Completed', reviewer: 'Sarah Manager', date: 'Mar 11' },
    { psw: 'Maria Santos', period: 'Q1 2026', overall: '4.2', quality: '4.5', punctuality: '4.0', communication: '4.3', status: '⏳ Pending Review', reviewer: 'Tom Supervisor', date: 'Mar 15' },
    { psw: 'James Wright', period: 'Q1 2026', overall: '3.6', quality: '3.8', punctuality: '3.2', communication: '3.5', status: '⚠️ Needs Improvement', reviewer: 'Sarah Manager', date: 'Mar 14' },
    { psw: 'Kevin O\'Brien', period: 'Q1 2026', overall: '—', quality: '—', punctuality: '—', communication: '—', status: '📝 Not Started', reviewer: 'Tom Supervisor', date: '—' },
];

// Inherited from hr.tsx
const reviewCols: TableColumn[] = [
    { key: 'psw', label: 'PSW' }, { key: 'overall', label: 'Overall' },
    { key: 'quality', label: 'Quality' }, { key: 'punctuality', label: 'Punctuality' },
    { key: 'communication', label: 'Communication' }, { key: 'status', label: 'Status' },
    { key: 'reviewer', label: 'Reviewer' }, { key: 'date', label: 'Date' },
];

// Inherited from iot.tsx
const deviceCols: TableColumn[] = [
    { key: 'client', label: 'Client' }, { key: 'device', label: 'Device' },
    { key: 'status', label: 'Status' }, { key: 'battery', label: 'Battery' },
    { key: 'signal', label: 'Signal' }, { key: 'lastPing', label: 'Last Ping' },
    { key: 'alerts', label: 'Alerts' },
];



// --- Stubs for dynamically extracted React State ---
export const tab = 'default';
export const setTab = () => {};
export const activeTab = 'default';
export const setActiveTab = () => {};
export const tabContent: Record<string, any> = {};
export const COMPLEX_KEY_0 = 'COMPLEX_KEY_0';
export const COMPLEX_KEY_1 = 'COMPLEX_KEY_1';
export const COMPLEX_KEY_2 = 'COMPLEX_KEY_2';
export const COMPLEX_KEY_3 = 'COMPLEX_KEY_3';
export const COMPLEX_KEY_4 = 'COMPLEX_KEY_4';
export const COMPLEX_KEY_5 = 'COMPLEX_KEY_5';
export const COMPLEX_KEY_6 = 'COMPLEX_KEY_6';
export const COMPLEX_KEY_215 = 'COMPLEX_KEY_215';
export const COMPLEX_KEY_216 = 'COMPLEX_KEY_216';
export const COMPLEX_KEY_217 = 'COMPLEX_KEY_217';
export const COMPLEX_KEY_220 = 'COMPLEX_KEY_220';


