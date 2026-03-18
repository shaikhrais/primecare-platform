export type TableColumn = any;
import { AdminRegistry } from 'prime-care-shared';

// Inherited from admission.tsx
const admissionSteps = [
    { icon: '📋', title: 'Referral Information', subtitle: 'Source, date, reason for referral & urgency level' },
    { icon: '👤', title: 'Client Demographics', subtitle: 'Name, DOB, address, contacts & emergency contacts' },
    { icon: '🏥', title: 'Medical History', subtitle: 'Diagnoses, medications, allergies & physician info' },
    { icon: '📊', title: 'Care Assessment', subtitle: 'RAI-HC, functional status & cognitive assessment' },
    { icon: '📝', title: 'Service Plan', subtitle: 'Approved services, hours, frequency & goals' },
    { icon: '✅', title: 'Consent & Documents', subtitle: 'Signed consents, ID verification & insurance' },
];

// Inherited from ai.tsx
const aiModules = [
    { icon: '🔮', title: 'Predictive Analytics', subtitle: 'Visit trends, churn, demand forecasting' },
    { icon: '💬', title: 'Sentiment Analysis', subtitle: 'Client & PSW satisfaction tracking' },
    { icon: '🎯', title: 'Visit Optimization', subtitle: 'Route & schedule optimization' },
    { icon: '⚠️', title: 'Churn Risk', subtitle: 'At-risk client identification' },
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
    { icon: '🗺️', title: 'Route Clustering — North York', subtitle: '3 visits can be grouped → save 45 min drive time' },
    { icon: '⏰', title: 'Schedule Gap — PSW Chen', subtitle: '2 hr gap between visits on Wed. Suggest backfill.' },
    { icon: '📍', title: 'Distance Alert — PSW Williams', subtitle: 'Visit #4 is 38km from #3. Suggest reassign.' },
    { icon: '✅', title: 'Optimal Match — Client Park', subtitle: 'PSW Santos best fit: 98% compatibility score' },
];

// Inherited from ai.tsx
const sentimentFeed = [
    { icon: '😊', title: 'Client Park: "PSW Santos is wonderful, always on time"', time: 'Today', level: 'success' as const },
    { icon: '😐', title: 'Client Brown: "Visit was fine, nothing special"', time: 'Yesterday', level: 'info' as const },
    { icon: '😟', title: 'Client Chen: "PSW arrived 20 min late, no notification"', time: '2 days ago', level: 'warning' as const },
    { icon: '😠', title: 'Family Williams: "Scheduling keeps changing without notice"', time: '3 days ago', level: 'danger' as const },
    { icon: '😊', title: 'Client Taylor: "Best care my mother has ever received"', time: '4 days ago', level: 'success' as const },
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
    { icon: '🔴', title: 'Susan Park — Auth expires Mar 31, 92% used, NO renewal filed', time: 'Urgent', level: 'danger' as const },
    { icon: '🟠', title: 'Margaret Chen — 82% used (98/120 hrs), 6 weeks remaining', time: '2 hrs ago', level: 'warning' as const },
    { icon: '🟡', title: 'James Brown — OT auth 75% used, renewal recommended', time: '1 day ago', level: 'warning' as const },
    { icon: '🟢', title: 'Helen Taylor — Renewal approved, new auth starts Apr 1', time: '2 days ago', level: 'success' as const },
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
    { icon: '🩺', title: 'Care Plan Builder', subtitle: 'Create & manage individualized care plans' },
    { icon: '💊', title: 'Medication Reconciliation', subtitle: 'Cross-check prescriptions, interactions & allergies' },
    { icon: '📋', title: 'Assessment Templates', subtitle: 'RAI-HC, InterRAI, MDS & custom assessments' },
    { icon: '🔬', title: 'Lab Integration', subtitle: 'Lab orders, results tracking & abnormal flags' },
    { icon: '📊', title: 'Outcome Tracking', subtitle: 'Goal progress, clinical indicators & trends' },
    { icon: '🤖', title: 'AI Clinical Suggestions', subtitle: 'Evidence-based care recommendations' },
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
    { icon: '📋', title: 'General Consent', subtitle: 'Standard service consent — annual renewal' },
    { icon: '📱', title: 'Telehealth Consent', subtitle: 'Virtual visit authorization — PHIPA compliant' },
    { icon: '💊', title: 'Medication Administration', subtitle: 'MAR consent for PSW-administered medications' },
    { icon: '📸', title: 'Photography/Video', subtitle: 'Media capture consent for documentation' },
    { icon: '🔬', title: 'Research Participation', subtitle: 'Optional research study consent' },
    { icon: '📊', title: 'Data Sharing', subtitle: 'Inter-provider health information sharing' },
];

// Inherited from content.tsx
const blogPosts = [
    { title: 'Introducing PrimeCare Home Care Platform', date: 'Mar 12, 2026', status: '✅ Published', views: 1240 },
    { title: 'HIPAA Compliance Best Practices for PSWs', date: 'Mar 8, 2026', status: '✅ Published', views: 890 },
    { title: 'Remote Patient Monitoring: The Future of Home Care', date: 'Mar 5, 2026', status: '📝 Draft', views: 0 },
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
    { icon: '📅', title: 'Schedule', subtitle: 'View & manage today\'s shifts' },
    { icon: '👥', title: 'Staff', subtitle: '82 PSWs, 4 RNs active' },
    { icon: '🏥', title: 'Clients', subtitle: '67 active clients' },
    { icon: '💰', title: 'Revenue', subtitle: '$185K MTD' },
    { icon: '📋', title: 'Compliance', subtitle: '98.2% score' },
    { icon: '🤖', title: 'AI Insights', subtitle: '8 actionable items' },
];

// Inherited from dashboard.tsx
const registryModules = [
    { icon: '📋', title: 'Page Registry', subtitle: '139 pages registered across admin & tenancy' },
    { icon: '🔗', title: 'API Registry', subtitle: '85 endpoints, 12 modules, 4 middleware chains' },
    { icon: '📊', title: 'Section Registry', subtitle: '15 section types, 60+ page configurations' },
    { icon: '🔑', title: 'Role Registry', subtitle: '6 roles, 142 permissions, 5 scopes' },
    { icon: '📡', title: 'Event Registry', subtitle: '24 event types, 6 automation hooks' },
    { icon: '🎨', title: 'Theme Registry', subtitle: '3 themes, 24 CSS variables, dark mode' },
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
    { icon: '📦', title: 'Inventory Management', subtitle: 'Medical supplies, PPE, equipment tracking' },
    { icon: '🛒', title: 'Purchase Orders', subtitle: 'Vendor POs, approval workflows, delivery tracking' },
    { icon: '🏭', title: 'Vendor Management', subtitle: 'Supplier directory, contracts, performance' },
    { icon: '📊', title: 'Demand Forecasting', subtitle: 'AI-predicted supply needs by location' },
    { icon: '🔍', title: 'Asset Tracking', subtitle: 'Equipment lifecycle, maintenance schedules' },
    { icon: '💰', title: 'Cost Analysis', subtitle: 'Spend analytics, category management' },
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
    { icon: '📋', title: 'Shift Overview', subtitle: 'Active shifts, coverage gaps, overtime tracking' },
    { icon: '🚗', title: 'Fleet & Logistics', subtitle: 'Vehicle tracking, route optimization, mileage' },
    { icon: '📊', title: 'Capacity Planning', subtitle: 'Demand forecasting, staffing models, utilization' },
    { icon: '⚡', title: 'Incident Command', subtitle: 'Active incidents, escalation chains, resolution SLAs' },
    { icon: '🔄', title: 'Workflow Automation', subtitle: 'Triggered actions, approval chains, notifications' },
    { icon: '📈', title: 'Performance Metrics', subtitle: 'KPIs, SLA adherence, quality scores' },
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
    { icon: '📋', title: 'Claims Management', subtitle: 'OHIP, WSIB & private insurer claim submission' },
    { icon: '💳', title: 'Billing & Invoicing', subtitle: 'Automated client billing, statement generation' },
    { icon: '🔄', title: 'ERA Processing', subtitle: 'Electronic remittance advice reconciliation' },
    { icon: '📊', title: 'Denial Management', subtitle: 'Track, appeal & resolve denied claims' },
    { icon: '💰', title: 'Collections', subtitle: 'Aging reports, follow-up automation' },
    { icon: '📈', title: 'Revenue Analytics', subtitle: 'Payer mix, reimbursement trends, forecasts' },
];

// Inherited from reference-data.tsx
const refDataModules = [
    { icon: '🗂️', title: 'Service Codes', subtitle: 'OHIP billing codes, service types & rates' },
    { icon: '📋', title: 'Diagnosis Codes', subtitle: 'ICD-10 code management & lookup' },
    { icon: '🏥', title: 'Facility Registry', subtitle: 'Care homes, clinics & satellite offices' },
    { icon: '💊', title: 'Drug Formulary', subtitle: 'Approved medications, NDC codes & interactions' },
    { icon: '📍', title: 'Service Areas', subtitle: 'Geographic zones, postal code mapping' },
    { icon: '📊', title: 'Fee Schedules', subtitle: 'Payer-specific rates, modifiers & contracts' },
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
    { icon: '📊', title: 'Financial Reports', subtitle: 'P&L, balance sheet, cash flow, aged receivables' },
    { icon: '👥', title: 'HR & Staffing', subtitle: 'Headcount, turnover, overtime, certification status' },
    { icon: '🏥', title: 'Clinical Reports', subtitle: 'Care plan outcomes, incident trends, med errors' },
    { icon: '📋', title: 'Compliance Reports', subtitle: 'HIPAA, PIPEDA, credential audits, training completion' },
    { icon: '📈', title: 'Operations Reports', subtitle: 'Visit volume, utilization, SLA adherence' },
    { icon: '🔍', title: 'Custom Builder', subtitle: 'Build ad-hoc reports with drag-and-drop fields' },
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
    { icon: '🔍', title: 'Threat Overview', subtitle: 'Active threats, intrusion attempts, blocked IPs' },
    { icon: '📋', title: 'Policy Compliance', subtitle: 'HIPAA, PIPEDA, SOC2 compliance status' },
    { icon: '🔑', title: 'Access Reviews', subtitle: 'Periodic access certification & role audits' },
    { icon: '🚨', title: 'Incident Response', subtitle: 'Active incidents, SLA tracking, resolution logs' },
];

// Inherited from security.tsx
const activityFeed = [
    { icon: '🔴', title: 'Brute force attempt blocked — 15 attempts from 185.220.x.x', time: '2 min ago', level: 'danger' as const },
    { icon: '🟠', title: 'PSW-045 role escalation detected — admin access requested', time: '15 min ago', level: 'warning' as const },
    { icon: '🟢', title: 'HIPAA compliance audit passed — all 47 checks green', time: '1 hr ago', level: 'success' as const },
    { icon: 'ℹ️', title: 'Session purge completed — 23 expired sessions removed', time: '2 hrs ago', level: 'info' as const },
    { icon: '🟢', title: 'SSL certificate renewed — expires Dec 2027', time: '3 hrs ago', level: 'success' as const },
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
    { icon: '🇨🇦', title: 'HST/GST Filing', subtitle: 'Next filing: Apr 30 — Q1 2026 | Estimated: $12,350' },
    { icon: '📋', title: 'WSIB Premiums', subtitle: 'Current rate: 2.46% | Annual est: $48,200' },
    { icon: '💳', title: 'T4/T4A Generation', subtitle: 'Due: Feb 28 | 82 employees processed' },
    { icon: '🏛️', title: 'EHT (Employer Health Tax)', subtitle: 'Ontario threshold: $1M | Current payroll: $1.8M' },
    { icon: '📊', title: 'CRA Audit Trail', subtitle: 'Last CRA correspondence: Jan 15 — resolved' },
    { icon: '🔒', title: 'PIPEDA Compliance', subtitle: 'Annual privacy impact assessment: ✅ Complete' },
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
    { icon: '🔴', title: 'Brute Force Attack — 185.220.101.42 — 47 attempts in 60s', time: '2 min ago', level: 'danger' as const },
    { icon: '🟠', title: 'Suspicious Login — admin@primecare.ca from new location (Kyiv, UA)', time: '15 min ago', level: 'warning' as const },
    { icon: '🟡', title: 'Rate Limit Exceeded — API endpoint /v1/admin/users — 250 req/min', time: '1 hr ago', level: 'warning' as const },
    { icon: '🟢', title: 'Vulnerability Scan Completed — 0 critical findings', time: '3 hrs ago', level: 'success' as const },
    { icon: '🟢', title: 'SSL Certificate Valid — expires Dec 2027', time: '6 hrs ago', level: 'success' as const },
    { icon: 'ℹ️', title: 'WAF rule update applied — 12 new signatures', time: '12 hrs ago', level: 'info' as const },
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


export const PageSectionRegistry: Record<string, any> = {
  // Extracted from components.tsx
  ['COMPLEX_KEY_0_546336']: {
                'mod.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'System Status', value: '100%', color: 'var(--pc-success)' },
                ]},
                'mod.body': { emptyState: { 
                    title: 'Biometric Login', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from forgot-password.tsx
  ['COMPLEX_KEY_1_573666']: {
                'mod.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'System Status', value: '100%', color: 'var(--pc-success)' },
                ]},
                'mod.body': { emptyState: { 
                    title: 'Forgot Password', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from login.tsx
  ['COMPLEX_KEY_2_121892']: {
                'mod.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'System Status', value: '100%', color: 'var(--pc-success)' },
                ]},
                'mod.body': { emptyState: { 
                    title: 'Login', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from onboard-business.tsx
  ['COMPLEX_KEY_3_291901']: {
                'mod.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'System Status', value: '100%', color: 'var(--pc-success)' },
                ]},
                'mod.body': { emptyState: { 
                    title: 'Business Onboard', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from index.tsx
  ['COMPLEX_KEY_4_487053']: {
                'mod.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'System Status', value: '100%', color: 'var(--pc-success)' },
                ]},
                'mod.body': { emptyState: { 
                    title: 'Vr Hoarding Simulator', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from register.tsx
  ['COMPLEX_KEY_5_796153']: {
                'mod.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'System Status', value: '100%', color: 'var(--pc-success)' },
                ]},
                'mod.body': { emptyState: { 
                    title: 'Register', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from reset-password.tsx
  ['COMPLEX_KEY_6_815375']: {
                'mod.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'System Status', value: '100%', color: 'var(--pc-success)' },
                ]},
                'mod.body': { emptyState: { 
                    title: 'Reset Password', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from admission.tsx
  ['F6']: {
                'F6.stats': { kpiCards: [
                    { label: 'In Progress', value: 3, color: 'var(--pc-warning)' },
                    { label: 'Completed Today', value: 1, color: 'var(--pc-success)' },
                    { label: 'Pending Review', value: 2, color: 'var(--pc-primary)' },
                    { label: 'Avg Intake Time', value: '2.5 days', color: 'var(--pc-info, #2563EB)' },
                ]},
                'F6.steps': { cardGrid: { items: admissionSteps, columns: 3 } },
            },

  // Extracted from ai.tsx
  ['D5']: {
                'D5.model-stats': { kpiCards: [
                    { label: 'Models Active', value: '1,247', color: '#8B5CF6' },
                    { label: 'Predictions Today', value: '3,829', color: 'var(--pc-primary)' },
                    { label: 'Accuracy', value: '94.2%', color: 'var(--pc-success)' },
                    { label: 'Alerts', value: 856, color: 'var(--pc-warning)' },
                ]},
                'D5.inference-chart': { chart: {
                    title: 'Inference Volume (Last 7 Days)',
                    type: 'bar',
                    data: [
                        { label: 'Mon', value: 520, color: '#8B5CF6' },
                        { label: 'Tue', value: 680, color: '#8B5CF6' },
                        { label: 'Wed', value: 590, color: '#8B5CF6' },
                        { label: 'Thu', value: 720, color: '#8B5CF6' },
                        { label: 'Fri', value: 830, color: '#8B5CF6' },
                        { label: 'Sat', value: 410, color: '#8B5CF6' },
                        { label: 'Sun', value: 280, color: '#8B5CF6' },
                    ],
                }},
                'D5.nav-cards': { cardGrid: { items: aiModules, columns: 4 } },
            },

  // Extracted from ai.tsx
  ['D20']: {
                'D20.ai-stats': { kpiCards: [
                    { label: 'AI Recommendations', value: 5, icon: '🎯', color: 'var(--pc-primary)' },
                    { label: 'Models Active', value: '4/5', icon: '🤖', color: 'var(--pc-success)' },
                    { label: 'Avg Confidence', value: '90.2%', icon: '📊', color: 'var(--pc-info, #2563EB)' },
                    { label: 'Predictions Today', value: 329, icon: '🔮', color: '#7C3AED' },
                    { label: 'Sentiment Score', value: '3.7/5', icon: '💭', color: 'var(--pc-warning)' },
                ]},
                'D20.recommendations': { tabs: {
                    tabs: [
                        { id: 'recommendations', label: '🎯 Recommendations', count: 5 },
                        { id: 'models', label: '🤖 AI Models', count: 5 },
                        { id: 'insights', label: '💡 Insights', count: 4 },
                    ],
                    activeTab: tab, onTabChange: setTab,
                }},
                ...tabContent[tab],
            },

  // Extracted from ai.tsx
  ['T52']: {
                'T52.stats': { kpiCards: [
                    { label: 'Models Running', value: 4, color: '#8B5CF6' },
                    { label: 'Predictions /Day', value: '3.8K', color: 'var(--pc-primary)' },
                    { label: 'Accuracy', value: '94.2%', color: 'var(--pc-success)' },
                    { label: 'Anomalies Found', value: 3, color: 'var(--pc-warning)' },
                ]},
                'T52.tabs': { tabs: { activeTab: tab, onTabChange: setTab } },
                ...tabContent[tab] || {},
            },

  // Extracted from ai.tsx
  ['T53']: {
                'T53.stats': { kpiCards: [
                    { label: 'At-Risk Clients', value: 4, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Avg Risk Score', value: '58.4%', color: 'var(--pc-warning)' },
                    { label: 'Interventions Active', value: 3, color: 'var(--pc-primary)' },
                    { label: 'Retention Rate', value: '94.1%', color: 'var(--pc-success)' },
                ]},
                'T53.churn-table': { table: { columns: churnCols, rows: churnClients } },
                'T53.trend': { chart: { title: 'Churn Risk Trend (6 Months)', type: 'bar', data: [
                    { label: 'Oct', value: 8 }, { label: 'Nov', value: 6 },
                    { label: 'Dec', value: 5 }, { label: 'Jan', value: 7 },
                    { label: 'Feb', value: 4 }, { label: 'Mar', value: 4 },
                ]}},
            },

  // Extracted from ai.tsx
  ['T54']: {
                'T54.stats': { kpiCards: [
                    { label: 'Routes Optimized', value: 12, color: 'var(--pc-primary)' },
                    { label: 'Time Saved', value: '4.2 hrs', color: 'var(--pc-success)' },
                    { label: 'Fuel Saved', value: '$142', color: '#10B981' },
                    { label: 'Suggestions', value: 4, color: 'var(--pc-info, #2563EB)' },
                ]},
                'T54.suggestions': { cardGrid: { items: optimizationSuggestions, columns: 2 } },
                'T54.efficiency': { chart: { title: 'Weekly Efficiency Gains', type: 'bar', data: [
                    { label: 'Mon', value: 35, color: '#10B981' }, { label: 'Tue', value: 42, color: '#10B981' },
                    { label: 'Wed', value: 28, color: '#10B981' }, { label: 'Thu', value: 51, color: '#10B981' },
                    { label: 'Fri', value: 38, color: '#10B981' },
                ]}},
            },

  // Extracted from ai.tsx
  ['T55']: {
                'T55.stats': { kpiCards: [
                    { label: 'Overall Score', value: '3.7/5', color: 'var(--pc-primary)' },
                    { label: 'Positive', value: '62%', color: 'var(--pc-success)' },
                    { label: 'Neutral', value: '28%', color: 'var(--pc-info, #2563EB)' },
                    { label: 'Negative', value: '10%', color: 'var(--pc-error, #ef4444)' },
                ]},
                'T55.trend': { chart: { title: 'Sentiment Trend (6 Months)', type: 'bar', data: [
                    { label: 'Oct', value: 72, color: '#10B981' }, { label: 'Nov', value: 68, color: '#F59E0B' },
                    { label: 'Dec', value: 74, color: '#10B981' }, { label: 'Jan', value: 65, color: '#F59E0B' },
                    { label: 'Feb', value: 71, color: '#10B981' }, { label: 'Mar', value: 62, color: '#F59E0B' },
                ]}},
                'T55.feed': { feed: { title: '📡 Recent Feedback', items: sentimentFeed } },
            },

  // Extracted from audit-export.tsx
  ['R10']: {
                'R10.stats': { kpiCards: [
                    { label: 'Compliance Score', value: '98.2%', color: 'var(--pc-success)' },
                    { label: 'Last Export', value: 'Today', color: 'var(--pc-primary)' },
                    { label: 'Issues Found', value: 2, color: 'var(--pc-warning)' },
                ]},
                'R10.modules': { cardGrid: { items: [
                    { icon: '🏥', title: 'HIPAA Compliance', subtitle: 'PHI access logs, breach notification status' },
                    { icon: '🇨🇦', title: 'PIPEDA Report', subtitle: 'Privacy impact assessment, consent tracking' },
                    { icon: '⚠️', title: 'OHSA Workplace Safety', subtitle: 'Incident reports, hazard assessments' },
                    { icon: '✅', title: 'Accreditation Prep', subtitle: 'Accreditation Ontario checklist & evidence' },
                ], columns: 2 } },
            },

  // Extracted from audit-export.tsx
  ['R13']: {
                'R13.stats': { kpiCards: [
                    { label: 'Reports Due', value: 2, color: 'var(--pc-warning)' },
                    { label: 'Submitted MTD', value: 3, color: 'var(--pc-success)' },
                    { label: 'Next Deadline', value: 'Apr 30', color: 'var(--pc-primary)' },
                ]},
                'R13.modules': { cardGrid: { items: [
                    { icon: '🏛️', title: 'CRA (Revenue Agency)', subtitle: 'T4/T4A, HST filing, payroll remittances' },
                    { icon: '⚙️', title: 'WSIB (Workplace Safety)', subtitle: 'Premium reports, claim submissions' },
                    { icon: '🏥', title: 'MOH (Ministry of Health)', subtitle: 'Service volume, quality indicators' },
                    { icon: '📋', title: 'ESA (Employment Standards)', subtitle: 'Hours of work, overtime, vacation tracking' },
                ], columns: 2 } },
            },

  // Extracted from audit-export.tsx
  ['R9']: {
                'R9.stats': { kpiCards: [
                    { label: 'Available Exports', value: 12, color: 'var(--pc-primary)' },
                    { label: 'Generated Today', value: 2, color: 'var(--pc-success)' },
                    { label: 'Total Records', value: '45K', color: 'var(--pc-info, #2563EB)' },
                ]},
                'R9.formats': { cardGrid: { items: [
                    { icon: '📄', title: 'CSV Export', subtitle: 'Raw audit data — all fields, filterable' },
                    { icon: '📋', title: 'PDF Report', subtitle: 'Formatted audit summary with charts' },
                    { icon: '🔐', title: 'Encrypted Archive', subtitle: 'HIPAA-compliant encrypted ZIP package' },
                ], columns: 3 } },
            },

  // Extracted from audits.tsx
  ['L6']: {
                'L6.stats': { kpiCards: [
                    { label: 'Events Today', value: 1247, color: 'var(--pc-primary)' },
                    { label: 'Users Active', value: 12, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Flagged', value: 3, color: 'var(--pc-warning)' },
                ]},
                'L6.table': { table: { columns: cols, rows: auditRows } },
            },

  // Extracted from authorizations.tsx
  ['L7']: {
                'L7.stats': { kpiCards: [
                    { label: 'Active Auths', value: 5, color: 'var(--pc-primary)' },
                    { label: 'Near Limit', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Critical', value: 1, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Avg Utilization', value: '70%', color: 'var(--pc-info, #2563EB)' },
                ]},
                'L7.table': { table: { columns: cols, rows: authRows } },
            },

  // Extracted from authorizations.tsx
  ['R6']: {
                'R6.stats': { kpiCards: [
                    { label: 'Avg Utilization', value: '70%', color: 'var(--pc-primary)' },
                    { label: 'Exhausting (>80%)', value: 3, color: 'var(--pc-warning)' },
                    { label: 'Renewals Due', value: 2, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Unused Hours', value: 340, color: 'var(--pc-success)' },
                ]},
                'R6.chart': { chart: { title: 'Utilization by Payer', type: 'horizontal-bar', data: [
                    { label: 'OHIP', value: 77, color: '#3B82F6' }, { label: 'WSIB', value: 30, color: '#10B981' },
                    { label: 'Private', value: 92, color: '#EF4444' }, { label: 'CCAC', value: 73, color: '#F59E0B' },
                ]}},
            },

  // Extracted from authorizations.tsx
  ['T49']: {
                'T49.stats': { kpiCards: [
                    { label: 'Critical', value: 1, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Warnings', value: 2, color: 'var(--pc-warning)' },
                    { label: 'Resolved', value: 1, color: 'var(--pc-success)' },
                ]},
                'T49.feed': { feed: { title: '🔔 Active Alerts', items: alertFeed } },
            },

  // Extracted from automation.tsx
  ['T7']: {
                'T7.stats': { kpiCards: [
                    { label: 'Active Automations', value: 6, color: 'var(--pc-primary)' },
                    { label: 'Runs Today', value: 847, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Success Rate', value: '99.8%', color: 'var(--pc-success)' },
                    { label: 'Failed', value: 2, color: 'var(--pc-error, #ef4444)' },
                ]},
                'T7.table': { table: { columns: cols, rows: automations } },
            },

  // Extracted from booking-requests.tsx
  ['L12']: {
                'L12.stats': { kpiCards: [
                    { label: 'Pending', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Confirmed', value: 1, color: 'var(--pc-success)' },
                    { label: 'Assigned', value: 1, color: 'var(--pc-primary)' },
                    { label: 'Avg Response', value: '4 hrs', color: 'var(--pc-info, #2563EB)' },
                ]},
                'L12.table': { table: { columns: cols, rows: bookings } },
            },

  // Extracted from claims.tsx
  ['L10']: {
                'L10.stats': { kpiCards: [
                    { label: 'Pending', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Paid MTD', value: '$8,590', color: 'var(--pc-success)' },
                    { label: 'Denied', value: 1, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Clean Rate', value: '80%', color: 'var(--pc-primary)' },
                ]},
                'L10.table': { table: { columns: cols_1, rows: claims } },
            },

  // Extracted from claims.tsx
  ['R12']: {
                'R12.stats': { kpiCards: [
                    { label: 'ERAs Received', value: 4, color: 'var(--pc-primary)' },
                    { label: 'Reconciled', value: '$45,700', color: 'var(--pc-success)' },
                    { label: 'Partial Match', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Auto-Post Rate', value: '92%', color: 'var(--pc-info, #2563EB)' },
                ]},
                'R12.table': { table: { columns: cols_2, rows: eraRows } },
            },

  // Extracted from clinical-assistant.tsx
  ['T8']: {
                'T8.stats': { kpiCards: [
                    { label: 'Active Care Plans', value: 67, color: 'var(--pc-primary)' },
                    { label: 'Assessments Due', value: 5, color: 'var(--pc-warning)' },
                    { label: 'AI Suggestions', value: 12, color: '#8B5CF6' },
                    { label: 'Compliance', value: '98%', color: 'var(--pc-success)' },
                ]},
                'T8.modules': { cardGrid: { items: clinicalModules, columns: 3 } },
            },

  // Extracted from communications.tsx
  ['H22']: {
                'H22.stats': { kpiCards: [
                    { label: 'Sent Today', value: 142, color: 'var(--pc-primary)' },
                    { label: 'Delivered', value: '96%', color: 'var(--pc-success)' },
                    { label: 'Failed', value: 3, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Cost MTD', value: '$48.30', color: 'var(--pc-info, #2563EB)' },
                ]},
                'H22.table': { table: { columns: cols, rows: smsLogs } },
            },

  // Extracted from consent.tsx
  ['L8']: {
                'L8.stats': { kpiCards: [
                    { label: 'Active Consents', value: 4, color: 'var(--pc-success)' },
                    { label: 'Expired', value: 1, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Expiring Soon', value: 0, color: 'var(--pc-warning)' },
                ]},
                'L8.table': { table: { columns: cols, rows: consents } },
            },

  // Extracted from consent.tsx
  ['R7']: {
                'R7.stats': { kpiCards: [
                    { label: 'Expiring 30d', value: 3, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Expiring 60d', value: 5, color: 'var(--pc-warning)' },
                    { label: 'Expiring 90d', value: 8, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Auto-Renewed', value: 12, color: 'var(--pc-success)' },
                ]},
                'R7.chart': { chart: { title: 'Expiration Timeline', type: 'bar', data: [
                    { label: '< 30d', value: 3, color: '#EF4444' }, { label: '30-60d', value: 5, color: '#F59E0B' },
                    { label: '60-90d', value: 8, color: '#3B82F6' }, { label: '> 90d', value: 45, color: '#10B981' },
                ]}},
            },

  // Extracted from consent.tsx
  ['T50']: {
                'T50.stats': { kpiCards: [
                    { label: 'Templates', value: 6, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 5, color: 'var(--pc-success)' },
                    { label: 'Draft', value: 1, color: 'var(--pc-warning)' },
                ]},
                'T50.templates': { cardGrid: { items: templates, columns: 3 } },
            },

  // Extracted from content.tsx
  ['T2']: {
                'T2.stats': { kpiCards: [
                    { label: 'Published', value: 2, color: 'var(--pc-success)' },
                    { label: 'Drafts', value: 1, color: 'var(--pc-warning)' },
                    { label: 'FAQs', value: 3, color: 'var(--pc-primary)' },
                    { label: 'Total Views', value: '2.1K', color: 'var(--pc-info, #2563EB)' },
                ]},
                'T2.tabs': { tabs: { activeTab: tab, onTabChange: setTab } },
                'T2.content': { table: {
                    columns: true ? blogCols : faqCols,
                    rows: true ? blogPosts : faqItems,
                }},
            },

  // Extracted from cron.tsx
  ['D6']: {
                'D6.job-stats': { kpiCards: [
                    { label: 'Total Jobs', value: 4, color: 'var(--pc-primary)' },
                    { label: 'Healthy', value: 3, color: 'var(--pc-success)' },
                    { label: 'Warning', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Failed', value: 0, color: 'var(--pc-error, #ef4444)' },
                ]},
                'D6.job-list': { table: { columns: jobCols, rows: cronJobs } },
                'D6.run-history': { chart: {
                    title: 'Job Execution History (Last 7 Days)',
                    type: 'bar',
                    data: [
                        { label: 'Mon', value: 8 }, { label: 'Tue', value: 12 },
                        { label: 'Wed', value: 10 }, { label: 'Thu', value: 12 },
                        { label: 'Fri', value: 14 }, { label: 'Sat', value: 4 },
                        { label: 'Sun', value: 4 },
                    ],
                }},
            },

  // Extracted from customers.tsx
  ['L15']: {
                'L15.stats': { kpiCards: [
                    { label: 'Total Clients', value: 67, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 64, color: 'var(--pc-success)' },
                    { label: 'Intake', value: 3, color: 'var(--pc-warning)' },
                    { label: 'Avg Age', value: 79, color: 'var(--pc-info, #2563EB)' },
                ]},
                'L15.table': { table: { columns: cols, rows: customers } },
            },

  // Extracted from dashboard.tsx
  ['D1']: {
                'D1.stats': { kpiCards: [
                    { label: 'Active Visits', value: 23, color: 'var(--pc-primary)' },
                    { label: 'Revenue MTD', value: '$185K', color: 'var(--pc-success)' },
                    { label: 'Staff Active', value: 86, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Clients', value: 67, color: '#7C3AED' },
                    { label: 'Compliance', value: '98.2%', color: '#10B981' },
                    { label: 'Incidents', value: 2, color: 'var(--pc-warning)' },
                ]},
                'D1.quick-actions': { cardGrid: { items: quickActions, columns: 3 } },
                'D1.visit-chart': { chart: { title: 'Weekly Visit Volume', type: 'bar', data: [
                    { label: 'Mon', value: 145 }, { label: 'Tue', value: 162 },
                    { label: 'Wed', value: 138 }, { label: 'Thu', value: 155 },
                    { label: 'Fri', value: 170 }, { label: 'Sat', value: 45 },
                    { label: 'Sun', value: 32 },
                ]}},
            },

  // Extracted from dashboard.tsx
  ['D2']: {
                'D2.stats': { kpiCards: [
                    { label: 'Total Pages', value: 139, color: 'var(--pc-primary)' },
                    { label: 'API Endpoints', value: 85, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Section Types', value: 15, color: '#8B5CF6' },
                    { label: 'Registries', value: 6, color: 'var(--pc-success)' },
                ]},
                'D2.registries': { cardGrid: { items: registryModules, columns: 3 } },
            },

  // Extracted from documents.tsx
  ['H6']: {
                'H6.stats': { kpiCards: [
                    { label: 'Total Documents', value: 5, color: 'var(--pc-primary)' },
                    { label: 'Pending Review', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Approved', value: 3, color: 'var(--pc-success)' },
                    { label: 'Rejected', value: 1, color: 'var(--pc-error, #ef4444)' },
                ]},
                'H6.table': { table: { columns: cols, rows: documents } },
            },

  // Extracted from earnings.tsx
  ['EARN']: {
                'EARN.stats': { kpiCards: [
                    { label: 'Total Revenue', value: '$1,913.25', color: 'var(--pc-success)' },
                    { label: 'Paid', value: 2, color: 'var(--pc-primary)' },
                    { label: 'Pending', value: 2, color: 'var(--pc-warning)' },
                    { label: 'Total Hours', value: '74.5', color: 'var(--pc-info, #2563EB)' },
                ]},
                'EARN.filters': { filters: {
                    searchPlaceholder: 'Search by Invoice, Client, or Service...',
                    filters: [{ label: 'Status', options: ['All Statuses', 'Paid', 'Pending'] }],
                }},
                'EARN.table': { table: { columns: cols, rows: earningsRows } },
            },

  // Extracted from erp.tsx
  ['H4']: {
                'H4.stats': { kpiCards: [
                    { label: 'SKUs', value: 342, color: 'var(--pc-primary)' },
                    { label: 'Open POs', value: 5, color: 'var(--pc-warning)' },
                    { label: 'Low Stock', value: 3, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Vendors', value: 12, color: 'var(--pc-info, #2563EB)' },
                ]},
                'H4.modules': { cardGrid: { items: erpModules, columns: 3 } },
            },

  // Extracted from evv.tsx
  ['D4']: {
                'D4.stats': { kpiCards: [
                    { label: 'Active Visits', value: 23, color: 'var(--pc-primary)' },
                    { label: 'On-Time Rate', value: '94%', color: 'var(--pc-success)' },
                    { label: 'GPS Verified', value: '98%', color: 'var(--pc-info, #2563EB)' },
                    { label: 'Exceptions', value: 3, color: 'var(--pc-warning)' },
                ]},
                'D4.map': { map: {
                    title: '📍 Live Visit Locations',
                    markers: [
                        { id: 'm1', lat: 43.65, lng: -79.38, label: 'PSW Santos — Chen residence', status: 'active' },
                        { id: 'm2', lat: 43.72, lng: -79.34, label: 'PSW Williams — Park home', status: 'active' },
                        { id: 'm3', lat: 43.68, lng: -79.42, label: 'PSW Brown — Taylor facility', status: 'active' },
                        { id: 'm4', lat: 43.71, lng: -79.40, label: 'PSW Chen — Williams home', status: 'danger' },
                    ],
                }},
                'D4.recent': { feed: { title: '📡 Live EVV Feed', items: [
                    { icon: '🟢', title: 'PSW Santos clocked in — Margaret Chen — GPS ✓', time: '14:23', level: 'success' as const },
                    { icon: '🟢', title: 'PSW Williams clocked out — Robert Williams — 2h 15m', time: '14:10', level: 'success' as const },
                    { icon: '🟡', title: 'PSW Brown — GPS outside service area (50m)', time: '13:55', level: 'warning' as const },
                    { icon: '🔴', title: 'PSW Chen — No clock-in for scheduled visit', time: '13:30', level: 'danger' as const },
                ]}},
            },

  // Extracted from evv.tsx
  ['L22']: {
                'L22.stats': { kpiCards: [
                    { label: 'Open', value: 2, color: 'var(--pc-warning)' },
                    { label: 'Resolved', value: 1, color: 'var(--pc-success)' },
                    { label: 'Avg Resolution', value: '4 hrs', color: 'var(--pc-info, #2563EB)' },
                ]},
                'L22.table': { table: { columns: cols, rows: exceptions } },
            },

  // Extracted from evv.tsx
  ['R8']: {
                'R8.stats': { kpiCards: [
                    { label: 'Exportable Records', value: '2.4K', color: 'var(--pc-primary)' },
                    { label: 'Last Export', value: 'Today', color: 'var(--pc-success)' },
                    { label: 'Format', value: 'CSV/XML', color: 'var(--pc-info, #2563EB)' },
                ]},
                'R8.formats': { cardGrid: { items: [
                    { icon: '📄', title: 'CSV Export', subtitle: 'Raw EVV data — all fields, date-filterable' },
                    { icon: '📋', title: 'XML (Payer Format)', subtitle: 'OHIP/CCAC-compliant structured format' },
                    { icon: '📊', title: 'Summary PDF', subtitle: 'Aggregated EVV compliance report' },
                ], columns: 3 } },
            },

  // Extracted from reconciliation.tsx
  ['T59']: {
                'T59.stats': { kpiCards: [
                    { label: 'Bank Feeds', value: 3, color: 'var(--pc-primary)' },
                    { label: 'Auto-Matched', value: 1, color: 'var(--pc-success)' },
                    { label: 'Fuzzy Matches', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Unmatched', value: 1, color: 'var(--pc-error, #EF4444)' },
                ]},
                'T59.table': { table: { columns: cols, rows: reconciliationRows } },
            },

  // Extracted from form-registry.tsx
  ['PGE-FC']: {
                ['PGE-' + 'FC.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'FC.empty']: { emptyState: { title: 'Form Card Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from form-registry.tsx
  ['PGE-FDV']: {
                ['PGE-' + 'FDV.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'FDV.empty']: { emptyState: { title: 'Form Detail View Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from franchise.tsx
  ['H30']: {
                'H30.overview-stats': { kpiCards: [
                    { label: 'Total Locations', value: 6, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 4, color: 'var(--pc-success)' },
                    { label: 'Total PSWs', value: 77, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Total Clients', value: 193, color: '#7C3AED' },
                    { label: 'Combined Revenue', value: '$418K', color: 'var(--pc-success)' },
                ]},
                'H30.location-table': { tabs: {
                    tabs: [
                        { id: 'locations', label: '📍 Locations', count: 6 },
                        { id: 'expansion', label: '🗺️ Expansion', count: 4 },
                    ],
                    activeTab: tab, onTabChange: setTab,
                }},
                ...tabContent[tab],
            },

  // Extracted from incidents.tsx
  ['F10']: {
                'F10.stats': { kpiCards: [
                    { label: 'Open Incidents', value: 2, color: 'var(--pc-warning)' },
                    { label: 'This Month', value: 4, color: 'var(--pc-primary)' },
                    { label: 'Avg Resolution', value: '3 days', color: 'var(--pc-info, #2563EB)' },
                    { label: 'Severity Avg', value: 'Low', color: 'var(--pc-success)' },
                ]},
                'F10.form': { cardGrid: { items: [
                    { icon: '📋', title: 'Incident Details', subtitle: 'Date, time, location & description' },
                    { icon: '👤', title: 'Involved Parties', subtitle: 'Client, PSW, witnesses & supervisor' },
                    { icon: '🏥', title: 'Injury Assessment', subtitle: 'Type, severity & treatment administered' },
                    { icon: '📊', title: 'Root Cause Analysis', subtitle: 'Contributing factors & prevention plan' },
                ], columns: 2 } },
            },

  // Extracted from incidents.tsx
  ['PGE-IEF']: {
                ['PGE-' + 'IEF.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'IEF.empty']: { emptyState: { title: 'Incident Entry Form Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from incidents.tsx
  ['PGE-IL']: {
                ['PGE-' + 'IL.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'IL.empty']: { emptyState: { title: 'Incident List Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from incidents.tsx
  ['L2']: {
                'L2.stats': { kpiCards: [
                    { label: 'Open', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Investigating', value: 1, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Closed MTD', value: 2, color: 'var(--pc-success)' },
                    { label: 'Total MTD', value: 4, color: 'var(--pc-primary)' },
                ]},
                'L2.table': { table: { columns: cols, rows: incidents } },
            },

  // Extracted from insights.tsx
  ['T9']: {
                'T9.stats': { kpiCards: [
                    { label: 'Insights Generated', value: 24, color: '#8B5CF6' },
                    { label: 'Actionable', value: 8, color: 'var(--pc-primary)' },
                    { label: 'Applied', value: 5, color: 'var(--pc-success)' },
                    { label: 'Model Accuracy', value: '94%', color: 'var(--pc-info, #2563EB)' },
                ]},
                'T9.feed': { feed: { title: '🧠 Recent Insights', items: [
                    { icon: '💡', title: 'Staffing: Add 2 PSWs in North York zone — demand ↑ 15% predicted next month', time: '1 hr ago', level: 'info' as const },
                    { icon: '⚠️', title: 'Churn Risk: Client Chen satisfaction declining — recommend PSW assignment review', time: '3 hrs ago', level: 'warning' as const },
                    { icon: '📈', title: 'Efficiency: Route optimization could save 12 hrs/week in Mississauga zone', time: '6 hrs ago', level: 'success' as const },
                    { icon: '🔔', title: 'Compliance: 3 PSW certifications expiring within 30 days', time: '1 day ago', level: 'danger' as const },
                ]}},
            },

  // Extracted from interoperability.tsx
  ['T5']: {
                'T5.stats': { kpiCards: [
                    { label: 'FHIR Resources', value: 24, color: 'var(--pc-primary)' },
                    { label: 'API Calls Today', value: '1.2K', color: 'var(--pc-info, #2563EB)' },
                    { label: 'Connected Systems', value: 3, color: 'var(--pc-success)' },
                    { label: 'Errors', value: 0, color: 'var(--pc-success)' },
                ]},
                'T5.resources': { cardGrid: { items: [
                    { icon: '👤', title: 'Patient', subtitle: 'Demographics, identifiers & contact info' },
                    { icon: '📋', title: 'Observation', subtitle: 'Vitals, lab results & assessments' },
                    { icon: '💊', title: 'MedicationRequest', subtitle: 'Prescriptions & medication orders' },
                    { icon: '📅', title: 'Encounter', subtitle: 'Visits, admissions & service events' },
                    { icon: '🏥', title: 'Organization', subtitle: 'Facilities, departments & teams' },
                    { icon: '🩺', title: 'Practitioner', subtitle: 'Providers, credentials & roles' },
                ], columns: 3 } },
            },

  // Extracted from invoices.tsx
  ['F9']: {
                'F9.stats': { kpiCards: [
                    { label: 'Draft Invoices', value: 3, color: 'var(--pc-warning)' },
                    { label: 'Sent MTD', value: 12, color: 'var(--pc-primary)' },
                    { label: 'Total Billed', value: '$42.5K', color: 'var(--pc-success)' },
                    { label: 'Overdue', value: 1, color: 'var(--pc-error, #ef4444)' },
                ]},
                'F9.form': { cardGrid: { items: [
                    { icon: '👤', title: 'Client & Payer', subtitle: 'Select client, payer, billing address' },
                    { icon: '📋', title: 'Service Lines', subtitle: 'Add services, hours, rates & adjustments' },
                    { icon: '💰', title: 'Payment Terms', subtitle: 'Due date, payment method, late fees' },
                    { icon: '📧', title: 'Delivery', subtitle: 'Email, print, or electronic submission' },
                ], columns: 2 } },
            },

  // Extracted from knowledge-base.tsx
  ['H8']: {
                'H8.stats': { kpiCards: [
                    { label: 'Articles', value: 148, color: 'var(--pc-primary)' },
                    { label: 'Categories', value: 12, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Views MTD', value: '2.4K', color: 'var(--pc-success)' },
                    { label: 'Last Updated', value: 'Today', color: '#7C3AED' },
                ]},
                'H8.categories': { cardGrid: { items: [
                    { icon: '📋', title: 'Standard Operating Procedures', subtitle: '42 articles — visit protocols, incident reporting' },
                    { icon: '🏥', title: 'Clinical Guidelines', subtitle: '28 articles — care plans, medication admin, wound care' },
                    { icon: '📊', title: 'HR & Policies', subtitle: '35 articles — employment standards, benefits, safety' },
                    { icon: '💻', title: 'Technology', subtitle: '18 articles — platform guides, EVV, telehealth setup' },
                    { icon: '📝', title: 'Training Materials', subtitle: '25 articles — onboarding, HIPAA, certifications' },
                ], columns: 3 } },
            },

  // Extracted from knowledge-base.tsx
  ['T48']: {
                'T48.form': { cardGrid: { items: [
                    { icon: '📝', title: 'Article Content', subtitle: 'Rich text editor, headings, lists & media' },
                    { icon: '🏷️', title: 'Metadata', subtitle: 'Category, tags, author & publish date' },
                    { icon: '🔗', title: 'Related Articles', subtitle: 'Link related SOPs, policies & guides' },
                    { icon: '👥', title: 'Access Control', subtitle: 'Visibility, role-based access & approval chain' },
                ], columns: 2 } },
            },

  // Extracted from leads.tsx
  ['F11']: {
                'F11.form': { cardGrid: { items: [
                    { icon: '👤', title: 'Contact Information', subtitle: 'Name, phone, email & preferred contact method' },
                    { icon: '🏥', title: 'Service Interest', subtitle: 'Requested service, urgency & availability' },
                    { icon: '📋', title: 'Source & Notes', subtitle: 'Referral source, initial notes & follow-up plan' },
                    { icon: '📊', title: 'Qualification', subtitle: 'Budget, timeline, decision maker & scoring' },
                ], columns: 2 } },
            },

  // Extracted from leads.tsx
  ['L3']: {
                'L3.pipeline': { kpiCards: [
                    { label: 'New', value: 1, color: '#6B7280' },
                    { label: 'Contact Made', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Qualified', value: 1, color: 'var(--pc-success)' },
                    { label: 'Proposal Sent', value: 1, color: 'var(--pc-info, #2563EB)' },
                ]},
                'L3.table': { table: { columns: cols, rows: leads } },
            },

  // Extracted from leads.tsx
  ['PGE-LEF']: {
                ['PGE-' + 'LEF.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'LEF.empty']: { emptyState: { title: 'Lead Entry Form Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from leads.tsx
  ['T66']: {
                'T66.stats': { kpiCards: [
                    { label: 'Conversion Rate', value: '72%', color: 'var(--pc-success)' },
                    { label: 'Avg Days to Convert', value: 5.2, color: 'var(--pc-primary)' },
                    { label: 'Ready to Convert', value: 3, color: 'var(--pc-warning)' },
                    { label: 'Converted MTD', value: 8, color: 'var(--pc-info, #2563EB)' },
                ]},
                'T66.chart': { chart: { title: 'Monthly Conversions', type: 'bar', data: [
                    { label: 'Oct', value: 6 }, { label: 'Nov', value: 8 },
                    { label: 'Dec', value: 5 }, { label: 'Jan', value: 10 },
                    { label: 'Feb', value: 7 }, { label: 'Mar', value: 8 },
                ]}},
            },

  // Extracted from locations.tsx
  ['F12']: {
                'F12.stats': { kpiCards: [
                    { label: 'Locations', value: 8, color: 'var(--pc-primary)' },
                    { label: 'Service Zones', value: 12, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Active Clients', value: 67, color: 'var(--pc-success)' },
                    { label: 'Coverage Area', value: '250 km²', color: '#7C3AED' },
                ]},
                'F12.map': { map: {
                    title: '📍 Service Area Coverage',
                    markers: [
                        { id: 'm1', lat: 43.65, lng: -79.38, label: 'HQ — Toronto', status: 'active' },
                        { id: 'm2', lat: 43.72, lng: -79.34, label: 'North York Office', status: 'active' },
                        { id: 'm3', lat: 43.59, lng: -79.64, label: 'Mississauga Branch', status: 'active' },
                        { id: 'm4', lat: 43.85, lng: -79.42, label: 'Richmond Hill Satellite', status: 'active' },
                    ],
                }},
            },

  // Extracted from locations.tsx
  ['PGE-LL']: {
                ['PGE-' + 'LL.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'LL.empty']: { emptyState: { title: 'Locations List Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from marketplace.tsx
  ['PG-276']: {
                'PG-276.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-276.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from notifications.tsx
  ['H5']: {
                'H5.stats': { kpiCards: [
                    { label: 'Sent Today', value: 342, color: 'var(--pc-primary)' },
                    { label: 'Delivery Rate', value: '98%', color: 'var(--pc-success)' },
                    { label: 'Templates', value: 18, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Channels', value: 4, color: '#7C3AED' },
                ]},
                'H5.channels': { cardGrid: { items: [
                    { icon: '📧', title: 'Email', subtitle: 'Transactional & marketing emails via SendGrid' },
                    { icon: '📱', title: 'SMS', subtitle: 'Twilio-powered text messages' },
                    { icon: '🔔', title: 'Push', subtitle: 'PWA push notifications via service worker' },
                    { icon: '💬', title: 'In-App', subtitle: 'Real-time notification bell & toast messages' },
                ], columns: 4 } },
                'H5.recent': { feed: { title: '📡 Recent Notifications', items: [
                    { icon: '📧', title: 'Visit Reminder — Margaret Chen — Tomorrow 10:00 AM', time: '5 min ago', level: 'info' as const },
                    { icon: '📱', title: 'Shift Confirmation SMS — PSW Santos', time: '15 min ago', level: 'success' as const },
                    { icon: '🔔', title: 'Auth Exhaustion Alert — Susan Park (92%)', time: '1 hr ago', level: 'warning' as const },
                ]}},
            },

  // Extracted from observability.tsx
  ['D6-OBS']: {
                'D6-OBS.stats': { kpiCards: [
                    { label: 'Uptime', value: '99.97%', color: 'var(--pc-success)' },
                    { label: 'P95 Latency', value: '142ms', color: 'var(--pc-primary)' },
                    { label: 'Errors/hr', value: 0.3, color: 'var(--pc-warning)' },
                    { label: 'Active Users', value: 12, color: 'var(--pc-info, #2563EB)' },
                ]},
                'D6-OBS.metrics': { chart: { title: 'Request Volume (Last 24h)', type: 'bar', data: [
                    { label: '00:00', value: 12 }, { label: '04:00', value: 3 },
                    { label: '08:00', value: 45 }, { label: '10:00', value: 78 },
                    { label: '12:00', value: 92 }, { label: '14:00', value: 85 },
                    { label: '16:00', value: 65 }, { label: '18:00', value: 42 },
                    { label: '20:00', value: 28 }, { label: '22:00', value: 15 },
                ]}},
                'D6-OBS.feed': { feed: { title: '🚨 Recent Alerts', items: [
                    { icon: '🟢', title: 'All systems operational', time: 'Now', level: 'success' as const },
                    { icon: '🟡', title: 'Worker CPU spike to 85% — auto-resolved', time: '2 hrs ago', level: 'warning' as const },
                    { icon: '🟢', title: 'Deploy #33 successful — zero downtime', time: '3 hrs ago', level: 'success' as const },
                ]}},
            },

  // Extracted from onboarding.tsx
  ['F7']: {
                'F7.stats': { kpiCards: [
                    { label: 'In Progress', value: 4, color: 'var(--pc-warning)' },
                    { label: 'Completed MTD', value: 6, color: 'var(--pc-success)' },
                    { label: 'Avg Days', value: 5.2, color: 'var(--pc-primary)' },
                    { label: 'Pending Docs', value: 8, color: 'var(--pc-error, #ef4444)' },
                ]},
                'F7.steps': { cardGrid: { items: [
                    { icon: '📋', title: 'Application Review', subtitle: 'Resume screening, reference checks, interview' },
                    { icon: '📄', title: 'Document Collection', subtitle: 'ID, VSS, CPR, First Aid, TB test, proof of training' },
                    { icon: '🎓', title: 'Training Modules', subtitle: 'HIPAA, WHMIS, Client Safety, Platform Use' },
                    { icon: '✅', title: 'Compliance Sign-Off', subtitle: 'Manager approval, credential verification, go-live' },
                ], columns: 4 } },
            },

  // Extracted from ops.tsx
  ['D7']: {
                'D7.stats': { kpiCards: [
                    { label: 'Active Shifts', value: 23, color: 'var(--pc-primary)' },
                    { label: 'Coverage', value: '96%', color: 'var(--pc-success)' },
                    { label: 'Open Incidents', value: 2, color: 'var(--pc-warning)' },
                    { label: 'Utilization', value: '87%', color: 'var(--pc-info, #2563EB)' },
                    { label: 'OT Hours Today', value: 8, color: '#F59E0B' },
                ]},
                'D7.modules': { cardGrid: { items: opsModules, columns: 3 } },
                'D7.trend': { chart: { title: 'Daily Visit Volume (This Week)', type: 'bar', data: [
                    { label: 'Mon', value: 145 }, { label: 'Tue', value: 162 },
                    { label: 'Wed', value: 138 }, { label: 'Thu', value: 155 },
                    { label: 'Fri', value: 170 }, { label: 'Sat', value: 45 },
                    { label: 'Sun', value: 32 },
                ]}},
            },

  // Extracted from ops.tsx
  ['T67']: {
                'T67.stats': { kpiCards: [
                    { label: 'Supply (PSWs)', value: 82, color: 'var(--pc-primary)' },
                    { label: 'Demand (Hrs/wk)', value: 3200, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Utilization', value: '87%', color: 'var(--pc-success)' },
                    { label: 'Coverage Gaps', value: 4, color: 'var(--pc-warning)' },
                ]},
                'T67.supply': { chart: { title: 'Supply vs Demand (Weekly)', type: 'bar', data: [
                    { label: 'Mon', value: 162, color: '#3B82F6' }, { label: 'Tue', value: 158, color: '#3B82F6' },
                    { label: 'Wed', value: 148, color: '#F59E0B' }, { label: 'Thu', value: 155, color: '#3B82F6' },
                    { label: 'Fri', value: 170, color: '#3B82F6' }, { label: 'Sat', value: 45, color: '#EF4444' },
                    { label: 'Sun', value: 32, color: '#EF4444' },
                ]}},
                'T67.forecast': { chart: { title: 'Demand Forecast (Next 4 Weeks)', type: 'bar', data: [
                    { label: 'Wk 12', value: 3200 }, { label: 'Wk 13', value: 3350 },
                    { label: 'Wk 14', value: 3100 }, { label: 'Wk 15', value: 3400 },
                ]}},
            },

  // Extracted from page-registry.tsx
  ['PGE-GV']: {
                ['PGE-' + 'GV.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'GV.empty']: { emptyState: { title: 'Grid View Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from page-registry.tsx
  ['PGE-IMV']: {
                ['PGE-' + 'IMV.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'IMV.empty']: { emptyState: { title: 'Identity Map View Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from page-registry.tsx
  ['PGE-TV']: {
                ['PGE-' + 'TV.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'TV.empty']: { emptyState: { title: 'Table View Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from pages.tsx
  ['PGE-TP']: {
                ['PGE-' + 'TP.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'TP.empty']: { emptyState: { title: 'Test Page Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from payroll.tsx
  ['H7']: {
                'H7.stats': { kpiCards: [
                    { label: 'Payroll MTD', value: '$147K', color: 'var(--pc-primary)' },
                    { label: 'Employees', value: 82, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Avg Hourly', value: '$24.50', color: 'var(--pc-success)' },
                    { label: 'OT Hours', value: 124, color: 'var(--pc-warning)' },
                ]},
                'H7.runs': { table: { columns: payrollCols, rows: payrollRuns } },
                'H7.trend': { chart: { title: 'Weekly Payroll (Last 8 Weeks)', type: 'bar', data: [
                    { label: 'W4', value: 138 }, { label: 'W5', value: 141 }, { label: 'W6', value: 140 },
                    { label: 'W7', value: 142 }, { label: 'W8', value: 139 }, { label: 'W9', value: 143 },
                    { label: 'W10', value: 145 }, { label: 'W11', value: 147 },
                ]}},
            },

  // Extracted from pharmacy.tsx
  ['H2']: {
                'H2.mar-summary': { kpiCards: [
                    { label: 'Active Prescriptions', value: 6, color: 'var(--pc-primary)' },
                    { label: 'Pending Renewals', value: 2, color: 'var(--pc-warning)' },
                    { label: 'MAR Compliance', value: '100%', color: 'var(--pc-success)' },
                    { label: 'Critical Alerts', value: 0, color: 'var(--pc-error, #ef4444)' },
                ]},
                'H2.prescriptions': { table: { columns: medCols, rows: prescriptions } },
            },

  // Extracted from rcm.tsx
  ['H3']: {
                'H3.stats': { kpiCards: [
                    { label: 'Revenue MTD', value: '$185K', color: 'var(--pc-success)' },
                    { label: 'Claims Pending', value: 12, color: 'var(--pc-warning)' },
                    { label: 'Collection Rate', value: '96.4%', color: 'var(--pc-primary)' },
                    { label: 'Days in A/R', value: 22, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Denials', value: 3, color: 'var(--pc-error, #ef4444)' },
                ]},
                'H3.modules': { cardGrid: { items: rcmModules, columns: 3 } },
                'H3.trend': { chart: { title: 'Monthly Collections (6 Months)', type: 'bar', data: [
                    { label: 'Oct', value: 168, color: '#10B981' }, { label: 'Nov', value: 174, color: '#10B981' },
                    { label: 'Dec', value: 155, color: '#F59E0B' }, { label: 'Jan', value: 182, color: '#10B981' },
                    { label: 'Feb', value: 179, color: '#10B981' }, { label: 'Mar', value: 185, color: '#10B981' },
                ]}},
            },

  // Extracted from reference-data.tsx
  ['H9']: {
                'H9.stats': { kpiCards: [
                    { label: 'Service Codes', value: 342, color: 'var(--pc-primary)' },
                    { label: 'Facilities', value: 8, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Drug Records', value: 1240, color: '#7C3AED' },
                    { label: 'Last Sync', value: 'Today', color: 'var(--pc-success)' },
                ]},
                'H9.modules': { cardGrid: { items: refDataModules, columns: 3 } },
            },

  // Extracted from referrals.tsx
  ['L9']: {
                'L9.stats': { kpiCards: [
                    { label: 'Pending Intake', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Accepted MTD', value: 3, color: 'var(--pc-success)' },
                    { label: 'Waitlisted', value: 1, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Avg Days to Accept', value: 2.5, color: 'var(--pc-primary)' },
                ]},
                'L9.table': { table: { columns: cols, rows: referrals } },
            },

  // Extracted from referrals.tsx
  ['R11']: {
                'R11.stats': { kpiCards: [
                    { label: 'Total Referrals MTD', value: 28, color: 'var(--pc-primary)' },
                    { label: 'Conversion Rate', value: '72%', color: 'var(--pc-success)' },
                    { label: 'Top Source', value: 'CCAC', color: 'var(--pc-info, #2563EB)' },
                    { label: 'Avg Time to Serve', value: '3.2 days', color: '#7C3AED' },
                ]},
                'R11.by-source': { chart: { title: 'Referrals by Source', type: 'donut', data: [
                    { label: 'CCAC', value: 40, color: '#3B82F6' }, { label: 'Hospital', value: 25, color: '#10B981' },
                    { label: 'Physician', value: 20, color: '#F59E0B' }, { label: 'Self', value: 15, color: '#8B5CF6' },
                ]}},
                'R11.trend': { chart: { title: 'Monthly Referral Volume', type: 'bar', data: [
                    { label: 'Oct', value: 22 }, { label: 'Nov', value: 25 }, { label: 'Dec', value: 18 },
                    { label: 'Jan', value: 30 }, { label: 'Feb', value: 24 }, { label: 'Mar', value: 28 },
                ]}},
            },

  // Extracted from reports.tsx
  ['R1']: {
                'R1.stats': { kpiCards: [
                    { label: 'Report Types', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Scheduled', value: 6, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Generated Today', value: 3, color: 'var(--pc-success)' },
                    { label: 'Exports', value: 15, color: '#7C3AED' },
                ]},
                'R1.modules': { cardGrid: { items: reportModules, columns: 3 } },
            },

  // Extracted from reports.tsx
  ['R2']: {
                'R2.stats': { kpiCards: [
                    { label: 'Export Types', value: 4, color: 'var(--pc-primary)' },
                    { label: 'Generated Today', value: 3, color: 'var(--pc-success)' },
                    { label: 'Scheduled', value: 2, color: 'var(--pc-info, #2563EB)' },
                ]},
                'R2.formats': { cardGrid: { items: [
                    { icon: '📄', title: 'CSV Export', subtitle: 'Raw data tables — clients, visits, timesheets, billing' },
                    { icon: '📋', title: 'PDF Reports', subtitle: 'Formatted reports with charts, summaries & branding' },
                    { icon: '📊', title: 'Excel Workbook', subtitle: 'Multi-sheet workbooks with pivot data & formulas' },
                    { icon: '🔗', title: 'JSON / API', subtitle: 'Machine-readable data for system integrations' },
                ], columns: 2 } },
            },

  // Extracted from reseller.tsx
  ['PG-131']: {
                'PG-131.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-131.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from reseller.tsx
  ['PG-390']: {
                'PG-390.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-390.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from role-editor.tsx
  ['PGE-RL']: {
                ['PGE-' + 'RL.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'RL.empty']: { emptyState: { title: 'Roles List Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from role-editor.tsx
  ['T4']: {
                'T4.stats': { kpiCards: [
                    { label: 'Roles', value: 6, color: 'var(--pc-primary)' },
                    { label: 'Users', value: 96, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Permissions', value: 142, color: '#7C3AED' },
                    { label: 'Custom Roles', value: 0, color: 'var(--pc-success)' },
                ]},
                'T4.table': { table: { columns: cols, rows: roles } },
            },

  // Extracted from schedule.tsx
  ['L1']: {
                'L1.stats': { kpiCards: [
                    { label: 'Shifts Today', value: 23, color: 'var(--pc-primary)' },
                    { label: 'Coverage', value: '96%', color: 'var(--pc-success)' },
                    { label: 'Open Shifts', value: 2, color: 'var(--pc-warning)' },
                    { label: 'OT Hours', value: 8, color: '#F59E0B' },
                ]},
                'L1.calendar': { calendar: {
                    events: [
                        { id: `evt-${Math.random()}`, date: '2026-03-16', title: 'PSW Santos → Chen', color: '#3B82F6' },
                        { id: `evt-${Math.random()}`, date: '2026-03-16', title: 'RN Johnson → Williams', color: '#10B981' },
                        { id: `evt-${Math.random()}`, date: '2026-03-17', title: 'PSW Brown → Taylor', color: '#3B82F6' },
                        { id: `evt-${Math.random()}`, date: '2026-03-18', title: 'OT Martinez → Brown', color: '#8B5CF6' },
                        { id: `evt-${Math.random()}`, date: '2026-03-20', title: 'PSW Santos → Park', color: '#3B82F6' },
                    ],
                }},
            },

  // Extracted from search.tsx
  ['T1']: {
                'T1.stats': { kpiCards: [
                    { label: 'Indexed Records', value: '45K', color: 'var(--pc-primary)' },
                    { label: 'Search Types', value: 8, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Searches Today', value: 142, color: 'var(--pc-success)' },
                ]},
                'T1.categories': { cardGrid: { items: [
                    { icon: '👥', title: 'Clients', subtitle: 'Search by name, ID, address or phone' },
                    { icon: '🏥', title: 'PSWs & Staff', subtitle: 'Search by name, badge, certifications' },
                    { icon: '📅', title: 'Visits & Shifts', subtitle: 'Search by date, client, PSW or status' },
                    { icon: '📄', title: 'Documents', subtitle: 'Search by type, provider or keyword' },
                    { icon: '🧾', title: 'Invoices & Claims', subtitle: 'Search by ID, client, payer or amount' },
                    { icon: '🚨', title: 'Incidents', subtitle: 'Search by type, date or severity' },
                ], columns: 3 } },
            },

  // Extracted from security.tsx
  ['D3']: {
                'D3.ledger-summary': { kpiCards: [
                    { label: 'Total Assets', value: '$2.4M', color: 'var(--pc-primary)' },
                    { label: 'Revenue MTD', value: '$185K', color: 'var(--pc-success)' },
                    { label: 'Expenses MTD', value: '$162K', color: 'var(--pc-warning)' },
                    { label: 'Net Income', value: '$23K', color: '#10B981' },
                    { label: 'Cash Flow', value: '+$41K', color: 'var(--pc-info, #2563EB)' },
                ]},
                'D3.pl-chart': { chart: { title: 'P&L — Revenue vs Expenses', type: 'bar', data: [
                    { label: 'Oct', value: 175, color: '#10B981' }, { label: 'Nov', value: 182, color: '#10B981' },
                    { label: 'Dec', value: 168, color: '#F59E0B' }, { label: 'Jan', value: 190, color: '#10B981' },
                    { label: 'Feb', value: 178, color: '#10B981' }, { label: 'Mar', value: 185, color: '#10B981' },
                ]}},
                'D3.journal-table': { table: { columns: journalCols, rows: recentJournals } },
                'D3.balance-sheet': { chart: { title: 'Asset Allocation', type: 'donut', data: [
                    { label: 'Cash', value: 45, color: '#10B981' }, { label: 'Receivables', value: 25, color: '#3B82F6' },
                    { label: 'Equipment', value: 18, color: '#F59E0B' }, { label: 'Prepaid', value: 12, color: '#8B5CF6' },
                ]}},
                'D3.cash-flow': { chart: { title: 'Cash Flow Forecast (Next 6 Months)', type: 'bar', data: [
                    { label: 'Apr', value: 38 }, { label: 'May', value: 42 },
                    { label: 'Jun', value: 35 }, { label: 'Jul', value: 48 },
                    { label: 'Aug', value: 44 }, { label: 'Sep', value: 51 },
                ]}},
            },

  // Extracted from security.tsx
  ['L24']: {
                'L24.stats': { kpiCards: [
                    { label: 'Total Events', value: 10, color: 'var(--pc-primary)' },
                    { label: 'Critical', value: 2, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Auth Failures', value: 2, color: 'var(--pc-warning)' },
                    { label: 'Unique Actors', value: 5, color: 'var(--pc-info, #2563EB)' },
                ]},
                'L24.audit-table': { table: { columns: auditCols, rows: auditEntries } },
            },

  // Extracted from security.tsx
  ['PGE-SD']: {
                ['PGE-' + 'SD.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'SD.empty']: { emptyState: { title: 'Security Dashboard Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from security.tsx
  ['T10']: {
                'T10.threat-stats': { kpiCards: [
                    { label: 'Active Threats', value: 3, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Blocked IPs', value: 127, color: 'var(--pc-warning)' },
                    { label: 'Compliance Score', value: '98.2%', color: 'var(--pc-success)' },
                    { label: 'Open Incidents', value: 1, color: '#7C3AED' },
                    { label: 'Last Audit', value: '2 hrs ago', color: 'var(--pc-info, #2563EB)' },
                ]},
                'T10.nav-cards': { cardGrid: { items: securityModules, columns: 4 } },
                'T10.activity-feed': { feed: { items: activityFeed, title: '📡 Security Activity Feed' } },
            },

  // Extracted from security.tsx
  ['T13']: {
                'T13.stats': { kpiCards: [
                    { label: 'Registered', value: 5, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 4, color: 'var(--pc-success)' },
                    { label: 'Untrusted', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Max per User', value: 3, color: 'var(--pc-info, #2563EB)' },
                ]},
                'T13.table': { table: { columns: cols_5, rows: devices } },
            },

  // Extracted from security.tsx
  ['T14']: {
                'T14.stats': { kpiCards: [
                    { label: 'Events Today', value: 1247, color: 'var(--pc-primary)' },
                    { label: 'Flagged', value: 3, color: 'var(--pc-warning)' },
                    { label: 'Unique Actors', value: 12, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Retention', value: '7 yrs', color: 'var(--pc-success)' },
                ]},
                'T14.log': { table: { columns: forensCols, rows: forens } },
            },

  // Extracted from security.tsx
  ['T15']: {
                'T15.stats': { kpiCards: [
                    { label: 'Allowed Origins', value: 4, color: 'var(--pc-primary)' },
                    { label: 'Pending Review', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Blocked Today', value: 0, color: 'var(--pc-success)' },
                    { label: 'Max Age', value: '86400s', color: 'var(--pc-info, #2563EB)' },
                ]},
                'T15.origins': { table: { columns: corsCols, rows: origins } },
            },

  // Extracted from security.tsx
  ['T16']: {
                'T16.stats': { kpiCards: [
                    { label: 'Records Verified', value: '45K', color: 'var(--pc-success)' },
                    { label: 'Integrity Score', value: '100%', color: 'var(--pc-primary)' },
                    { label: 'Last Scan', value: 'Today 06:00', color: 'var(--pc-info, #2563EB)' },
                    { label: 'Tamper Alerts', value: 0, color: 'var(--pc-success)' },
                ]},
                'T16.modules': { cardGrid: { items: [
                    { icon: '🔐', title: 'Database Checksums', subtitle: 'SHA-256 validation of all critical tables' },
                    { icon: '📋', title: 'Audit Log Integrity', subtitle: 'Immutable log chain verification' },
                    { icon: '📄', title: 'Document Fingerprints', subtitle: 'File hash comparison for uploaded docs' },
                    { icon: '🔍', title: 'API Response Signing', subtitle: 'Response integrity verification headers' },
                ], columns: 2 } },
            },

  // Extracted from security.tsx
  ['T17']: {
                'T17.stats': { kpiCards: [
                    { label: 'Total Assets', value: '$2.4M', color: 'var(--pc-primary)' },
                    { label: 'Revenue MTD', value: '$185K', color: 'var(--pc-success)' },
                    { label: 'Expenses MTD', value: '$162K', color: 'var(--pc-warning)' },
                    { label: 'Net Income', value: '$23K', color: '#10B981' },
                ]},
                'T17.journal': { table: { columns: ledgerCols, rows: journalEntries } },
                'T17.pl-chart': { chart: { title: 'Revenue vs Expenses (6 Months)', type: 'bar', data: [
                    { label: 'Oct', value: 175, color: '#10B981' }, { label: 'Nov', value: 182, color: '#10B981' },
                    { label: 'Dec', value: 168, color: '#F59E0B' }, { label: 'Jan', value: 190, color: '#10B981' },
                    { label: 'Feb', value: 178, color: '#10B981' }, { label: 'Mar', value: 185, color: '#10B981' },
                ]}},
            },

  // Extracted from security.tsx
  ['T18']: {
                'T18.stats': { kpiCards: [
                    { label: 'HST Owing', value: '$12,350', color: 'var(--pc-warning)' },
                    { label: 'Next Filing', value: 'Apr 30', color: 'var(--pc-primary)' },
                    { label: 'Compliance Score', value: '100%', color: 'var(--pc-success)' },
                    { label: 'Open Items', value: 0, color: 'var(--pc-success)' },
                ]},
                'T18.modules': { cardGrid: { items: complianceCards, columns: 3 } },
            },

  // Extracted from security.tsx
  ['T56']: {
                'T56.stats': { kpiCards: [
                    { label: 'Roles', value: 25, color: 'var(--pc-primary)' },
                    { label: 'Permissions', value: 60, color: '#7C3AED' },
                    { label: 'Users', value: 99, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Conflicts', value: 0, color: 'var(--pc-success)' },
                ]},
                'T56.matrix': { table: { columns: roleCols, rows: roleMatrix } },
                'T56.distribution': { chart: { title: 'Permission Distribution by Role', type: 'donut', data: [
                    { label: 'Admin', value: 60, color: '#EF4444' },
                    { label: 'Manager', value: 42, color: '#F59E0B' },
                    { label: 'RN', value: 35, color: '#3B82F6' },
                    { label: 'Coordinator', value: 28, color: '#8B5CF6' },
                    { label: 'Finance', value: 18, color: '#10B981' },
                    { label: 'PSW', value: 12, color: '#6B7280' },
                ]}},
            },

  // Extracted from security.tsx
  ['T57']: {
                'T57.stats': { kpiCards: [
                    { label: 'Active Sessions', value: 4, color: 'var(--pc-primary)' },
                    { label: 'Blocked', value: 1, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Avg Duration', value: '1.1 hrs', color: 'var(--pc-info, #2563EB)' },
                    { label: 'Unique IPs', value: 5, color: '#7C3AED' },
                ]},
                'T57.sessions': { table: { columns: sessionCols, rows: sessions } },
            },

  // Extracted from security.tsx
  ['T58']: {
                'T58.stats': { kpiCards: [
                    { label: 'Active Threats', value: 1, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Blocked Today', value: 47, color: 'var(--pc-warning)' },
                    { label: 'WAF Rules', value: 234, color: 'var(--pc-primary)' },
                    { label: 'Uptime', value: '99.98%', color: 'var(--pc-success)' },
                ]},
                'T58.threat-feed': { feed: { title: '📡 Live Threat Feed', items: threats } },
                'T58.history': { chart: { title: 'Blocked Attacks (7 Days)', type: 'bar', data: [
                    { label: 'Mon', value: 23, color: '#EF4444' }, { label: 'Tue', value: 15, color: '#EF4444' },
                    { label: 'Wed', value: 8, color: '#F59E0B' }, { label: 'Thu', value: 31, color: '#EF4444' },
                    { label: 'Fri', value: 47, color: '#EF4444' }, { label: 'Sat', value: 12, color: '#F59E0B' },
                    { label: 'Sun', value: 5, color: '#10B981' },
                ]}},
            },

  // Extracted from services.tsx
  ['L5']: {
                'L5.stats': { kpiCards: [
                    { label: 'Service Types', value: 6, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 6, color: 'var(--pc-success)' },
                    { label: 'Total Clients', value: 111, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Avg Rate', value: '$37.33', color: '#7C3AED' },
                ]},
                'L5.table': { table: { columns: cols, rows: services } },
            },

  // Extracted from settings.tsx
  ['S8']: {
                'S8.stats': { kpiCards: [
                    { label: 'Base Currency', value: 'CAD 🇨🇦', color: 'var(--pc-primary)' },
                    { label: 'Active Currencies', value: 4, color: 'var(--pc-success)' },
                    { label: 'Last Rate Update', value: '2 hrs ago', color: 'var(--pc-info, #2563EB)' },
                    { label: 'FX Transactions', value: 156, color: '#7C3AED' },
                ]},
                'S8.rate-table': { table: { columns: currencyCols, rows: currencies } },
                'S8.fx-history': { table: { columns: fxCols, rows: fxTransactions } },
            },

  // Extracted from settings.tsx
  ['T11']: {
                'T11.modules': { cardGrid: { items: [
                    { icon: '🎨', title: 'Branding', subtitle: 'Logo, colors, fonts & white-label config' },
                    { icon: '🔗', title: 'Integrations', subtitle: 'Twilio, SendGrid, Stripe, OHIP, EMR connections' },
                    { icon: '🔐', title: 'Security', subtitle: 'Password policy, MFA, session timeout, IP whitelist' },
                    { icon: '📧', title: 'Email Templates', subtitle: 'Notification templates, signatures & branding' },
                    { icon: '🌐', title: 'Localization', subtitle: 'Language, timezone, date format & currency' },
                    { icon: '📊', title: 'Data Management', subtitle: 'Backup, export, retention policies & GDPR tools' },
                ], columns: 3 } },
            },

  // Extracted from setup.tsx
  ['H19']: {
                'H19.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from setup.tsx
  ['T12']: {
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
            },

  // Extracted from setup.tsx
  ['W1']: { 'W1.steps': { cardGrid: { items: [
            { icon: '1️⃣', title: 'Organization Info', subtitle: 'Legal name, address, business number' },
            { icon: '2️⃣', title: 'License & Compliance', subtitle: 'LHIN, MOH, OHIP provider number' },
            { icon: '3️⃣', title: 'Service Configuration', subtitle: 'Service types, rates, zones' },
            { icon: '4️⃣', title: 'Payment & Billing', subtitle: 'Bank info, payer setup, tax config' },
            { icon: '5️⃣', title: 'Integrations', subtitle: 'Email, SMS, EMR, EVV, payroll' },
            { icon: '6️⃣', title: 'Go Live', subtitle: 'Final checks, user invites, launch' },
        ], columns: 3 } } },

  // Extracted from setup.tsx
  ['W2']: { 'W2.steps': { cardGrid: { items: [
            { icon: '1️⃣', title: 'Personal Details', subtitle: 'Contact info, emergency contacts, demographics' },
            { icon: '2️⃣', title: 'Credentials', subtitle: 'CPR, First Aid, VSS, TB test, training certs' },
            { icon: '3️⃣', title: 'Training Modules', subtitle: 'HIPAA, WHMIS, platform training, safety' },
            { icon: '4️⃣', title: 'Go Live', subtitle: 'Supervisor sign-off, badge issue, first shift' },
        ], columns: 4 } } },

  // Extracted from setup.tsx
  ['W3']: { 'W3.steps': { cardGrid: { items: [
            { icon: '1️⃣', title: 'Client Assessment', subtitle: 'RAI-HC, functional status, cognitive & risk factors' },
            { icon: '2️⃣', title: 'Goals & Outcomes', subtitle: 'SMART goals, measurement criteria, timeline' },
            { icon: '3️⃣', title: 'Interventions', subtitle: 'Service plan, frequency, provider assignments' },
            { icon: '4️⃣', title: 'Review & Approve', subtitle: 'Clinical review, family consent, publish' },
        ], columns: 4 } } },

  // Extracted from setup.tsx
  ['W4']: { 'W4.steps': { cardGrid: { items: [
            { icon: '1️⃣', title: 'Payer Setup', subtitle: 'OHIP, WSIB, CCAC, private insurers' },
            { icon: '2️⃣', title: 'Fee Schedules', subtitle: 'Service rates, modifiers, volume discounts' },
            { icon: '3️⃣', title: 'Billing Rules', subtitle: 'Auto-billing triggers, approval chains' },
            { icon: '4️⃣', title: 'Collections', subtitle: 'Aging thresholds, late fees, follow-up automation' },
        ], columns: 4 } } },

  // Extracted from setup.tsx
  ['W5']: { 'W5.steps': { cardGrid: { items: [
            { icon: '1️⃣', title: 'Model Selection', subtitle: 'Franchise, corporate, hybrid or white-label' },
            { icon: '2️⃣', title: 'Territory Setup', subtitle: 'Geographic zones, exclusive areas, overlap rules' },
            { icon: '3️⃣', title: 'Revenue Sharing', subtitle: 'Commission rates, royalty structure, payouts' },
            { icon: '4️⃣', title: 'Launch', subtitle: 'Branding, domains, onboarding materials' },
        ], columns: 4 } } },

  // Extracted from sovereign.tsx
  ['T6']: {
                'T6.stats': { kpiCards: [
                    { label: 'DIDs Issued', value: 96, color: '#8B5CF6' },
                    { label: 'Verifiable Creds', value: 342, color: 'var(--pc-primary)' },
                    { label: 'Verifications', value: '1.2K', color: 'var(--pc-success)' },
                    { label: 'Trust Score', value: '99.9%', color: 'var(--pc-info, #2563EB)' },
                ]},
                'T6.modules': { cardGrid: { items: [
                    { icon: '🪪', title: 'Decentralized IDs (DIDs)', subtitle: 'Self-sovereign identifiers for staff & clients' },
                    { icon: '📜', title: 'Verifiable Credentials', subtitle: 'Tamper-proof digital certificates & licenses' },
                    { icon: '🔗', title: 'Trust Registry', subtitle: 'Credential schemas, issuers & verifiers' },
                    { icon: '🔍', title: 'Verification Portal', subtitle: 'Instant credential verification for employers' },
                ], columns: 2 } },
            },

  // Extracted from strategy.tsx
  ['PG-605']: {
                'PG-605.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-605.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from supply-chain.tsx
  ['L25']: {
                'L25.chain-stats': { kpiCards: [
                    { label: 'Items', value: 7, color: 'var(--pc-primary)' },
                    { label: 'Low Stock', value: 2, color: 'var(--pc-warning)' },
                    { label: 'Critical', value: 1, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Suppliers', value: 5, color: 'var(--pc-success)' },
                    { label: 'Open POs', value: 3, color: 'var(--pc-info, #2563EB)' },
                ]},
                'L25.inventory-table': { tabs: {
                    tabs: [
                        { id: 'inventory', label: '📋 Inventory', count: 7 },
                        { id: 'suppliers', label: '🏢 Suppliers', count: 5 },
                        { id: 'orders', label: '🛒 Orders', count: 4 },
                    ],
                    activeTab: tab, onTabChange: setTab,
                }},
                ...tabContent[tab],
            },

  // Extracted from support.tsx
  ['PG-828']: {
                'PG-828.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-828.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from telehealth.tsx
  ['H1']: {
                'H1.session-stats': { kpiCards: [
                    { label: 'Active Sessions', value: 2, color: 'var(--pc-primary)' },
                    { label: 'Scheduled Today', value: 8, color: 'var(--pc-info, #2563EB)' },
                    { label: 'RPM Devices', value: 34, color: 'var(--pc-success)' },
                    { label: 'Critical Alerts', value: 1, color: 'var(--pc-error, #ef4444)' },
                ]},
                'H1.active-sessions': { table: { columns: sessionCols, rows: sessionData } },
                // @ts-ignore
                'H1.alerts': { alerts: rpmAlerts },
            },

  // Extracted from template-editor.tsx
  ['PGE-TL']: {
                ['PGE-' + 'TL.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'TL.empty']: { emptyState: { title: 'Templates List Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from template-editor.tsx
  ['T3']: {
                'T3.stats': { kpiCards: [
                    { label: 'Templates', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Email', value: 12, color: 'var(--pc-info, #2563EB)' },
                    { label: 'SMS', value: 6, color: 'var(--pc-success)' },
                    { label: 'PDF', value: 6, color: '#7C3AED' },
                ]},
                'T3.modules': { cardGrid: { items: [
                    { icon: '📧', title: 'Email Templates', subtitle: 'Visit reminders, billing, welcome, security alerts' },
                    { icon: '📱', title: 'SMS Templates', subtitle: 'Shift confirmations, schedule changes, auth alerts' },
                    { icon: '📄', title: 'PDF Templates', subtitle: 'Invoices, reports, care plans, timesheets' },
                    { icon: '📋', title: 'Form Templates', subtitle: 'Intake forms, assessments, incident reports' },
                ], columns: 2 } },
            },

  // Extracted from timesheet-adjustment.tsx
  ['F8']: {
                'F8.stats': { kpiCards: [
                    { label: 'Pending', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Approved MTD', value: 2, color: 'var(--pc-success)' },
                    { label: 'Net Change', value: '+1.0 hrs', color: 'var(--pc-primary)' },
                ]},
                'F8.table': { table: { columns: cols, rows: adjustments } },
            },

  // Extracted from timesheets.tsx
  ['L4']: {
                'L4.stats': { kpiCards: [
                    { label: 'Pending Approval', value: 2, color: 'var(--pc-warning)' },
                    { label: 'Approved', value: 2, color: 'var(--pc-success)' },
                    { label: 'Total Hours', value: '146.5', color: 'var(--pc-primary)' },
                    { label: 'OT Hours', value: 6.5, color: '#F59E0B' },
                ]},
                'L4.table': { table: { columns: cols, rows: timesheets } },
            },

  // Extracted from users.tsx
  ['F9a']: {
                'F9a.form': { cardGrid: { items: [
                    { icon: '👤', title: 'Personal Information', subtitle: 'Name, email, phone & profile details' },
                    { icon: '🔑', title: 'Role & Permissions', subtitle: 'Assign role, custom permissions & access level' },
                    { icon: '🏥', title: 'Organization', subtitle: 'Department, team, supervisor & location' },
                    { icon: '🔐', title: 'Security', subtitle: 'MFA requirement, password policy & device limits' },
                ], columns: 2 } },
            },

  // Extracted from users.tsx
  ['L3a']: {
                'L3a.stats': { kpiCards: [
                    { label: 'Total Users', value: 99, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 94, color: 'var(--pc-success)' },
                    { label: 'Inactive', value: 5, color: 'var(--pc-warning)' },
                    { label: 'Roles', value: 6, color: 'var(--pc-info, #2563EB)' },
                ]},
                'L3a.table': { table: { columns: cols, rows: users } },
            },

  // Extracted from webhooks.tsx
  ['L11']: {
                'L11.stats': { kpiCards: [
                    { label: 'Endpoints', value: 3, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 2, color: 'var(--pc-success)' },
                    { label: 'Failing', value: 1, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Deliveries Today', value: 142, color: 'var(--pc-info, #2563EB)' },
                ]},
                'L11.table': { table: { columns: cols_1, rows: webhooks } },
            },

  // Extracted from webhooks.tsx
  ['T51']: {
                'T51.stats': { kpiCards: [
                    { label: 'Deliveries Today', value: 142, color: 'var(--pc-primary)' },
                    { label: 'Success Rate', value: '94%', color: 'var(--pc-success)' },
                    { label: 'Failed', value: 8, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Retrying', value: 2, color: 'var(--pc-warning)' },
                ]},
                'T51.table': { table: { columns: cols_2, rows: deliveries } },
            },

  // Extracted from audit-logs.tsx
  ['PG-614']: {
                'PG-614.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-614.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from accessibility.tsx
  ['PGE-SRC']: {
                ['PGE-' + 'SRC.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'SRC.empty']: { emptyState: { title: 'Screen Reader Content Editor Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from analytics.tsx
  ['PGE-ALH']: {
                ['PGE-' + 'ALH.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'ALH.empty']: { emptyState: { title: 'Api Latency Heatmap Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from analytics.tsx
  ['PGE-BMT']: {
                ['PGE-' + 'BMT.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'BMT.empty']: { emptyState: { title: 'Browser Matrix Telemetry Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from analytics.tsx
  ['PGE-CWV']: {
                ['PGE-' + 'CWV.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'CWV.empty']: { emptyState: { title: 'Core Web Vitals Tracker Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from compliance.tsx
  ['PGE-LCB']: {
                ['PGE-' + 'LCB.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'LCB.empty']: { emptyState: { title: 'Legal Compliance Blockers Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from content.tsx
  ['PGE-DPR']: {
                ['PGE-' + 'DPR.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'DPR.empty']: { emptyState: { title: 'Dynamic Page Router Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from content.tsx
  ['PGE-MCA']: {
                ['PGE-' + 'MCA.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'MCA.empty']: { emptyState: { title: 'Micro Copy Ab Testing Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from content.tsx
  ['PGE-RTG']: {
                ['PGE-' + 'RTG.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'RTG.empty']: { emptyState: { title: 'Rich Text Governance Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from design.tsx
  ['PGE-DTE']: {
                ['PGE-' + 'DTE.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'DTE.empty']: { emptyState: { title: 'Dynamic Token Editor Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from design.tsx
  ['PGE-FTR']: {
                ['PGE-' + 'FTR.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'FTR.empty']: { emptyState: { title: 'Font Typography Registry Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from governance.tsx
  ['PGE-ACA']: {
                ['PGE-' + 'ACA.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'ACA.empty']: { emptyState: { title: 'Asset Cost Attribution Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from governance.tsx
  ['PGE-EBA']: {
                ['PGE-' + 'EBA.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'EBA.empty']: { emptyState: { title: 'Error Boundary Aggregator Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from governance.tsx
  ['PGE-TPS']: {
                ['PGE-' + 'TPS.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'TPS.empty']: { emptyState: { title: 'Third Party Script Manager Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from localization.tsx
  ['PGE-GI1']: {
                ['PGE-' + 'GI1.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'GI1.empty']: { emptyState: { title: 'Global I18n Dictionary Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from media.tsx
  ['PGE-AEM']: {
                ['PGE-' + 'AEM.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'AEM.empty']: { emptyState: { title: 'Asset Expiration Manager Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from media.tsx
  ['PGE-CMV']: {
                ['PGE-' + 'CMV.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'CMV.empty']: { emptyState: { title: 'Central Media Vault Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from media.tsx
  ['PGE-MUH']: {
                ['PGE-' + 'MUH.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'MUH.empty']: { emptyState: { title: 'Media Usage Heatmap Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from media.tsx
  ['PGE-SDR']: {
                ['PGE-' + 'SDR.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'SDR.empty']: { emptyState: { title: 'Secure Document Redactor Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from media.tsx
  ['PGE-TPC']: {
                ['PGE-' + 'TPC.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'TPC.empty']: { emptyState: { title: 'Third Party Cdn Sync Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from security.tsx
  ['PGE-APM']: {
                ['PGE-' + 'APM.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'APM.empty']: { emptyState: { title: 'Asset Permission Matrix Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from security.tsx
  ['PGE-GDK']: {
                ['PGE-' + 'GDK.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'GDK.empty']: { emptyState: { title: 'Global Digital Kill Switch Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from templates.tsx
  ['PGE-NCB']: {
                ['PGE-' + 'NCB.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'NCB.empty']: { emptyState: { title: 'No Code Builder Mock Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from traffic.tsx
  ['PGE-AVM']: {
                ['PGE-' + 'AVM.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'AVM.empty']: { emptyState: { title: 'Ab Variant Manager Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from workflows.tsx
  ['PGE-AER']: {
                ['PGE-' + 'AER.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'AER.empty']: { emptyState: { title: 'Api Endpoint Registry Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from workflows.tsx
  ['PGE-ARL']: {
                ['PGE-' + 'ARL.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'ARL.empty']: { emptyState: { title: 'Api Rate Limit Config Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from workflows.tsx
  ['PGE-EPI']: {
                ['PGE-' + 'EPI.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'EPI.empty']: { emptyState: { title: 'Error Payload Inspector Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from workflows.tsx
  ['PGE-FSF']: {
                ['PGE-' + 'FSF.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'FSF.empty']: { emptyState: { title: 'Form Schema Federator Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from workflows.tsx
  ['PGE-VLB']: {
                ['PGE-' + 'VLB.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'VLB.empty']: { emptyState: { title: 'Visual Logic Builder Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from workflows.tsx
  ['PGE-WVC']: {
                ['PGE-' + 'WVC.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'WVC.empty']: { emptyState: { title: 'Workflow Version Control Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from dashboard.tsx
  ['PG-419']: {
                'PG-419.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-419.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from governance-hub.tsx
  ['PG-307']: {
                'PG-307.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-307.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from b2b.tsx
  ['PGE-B2S']: {
                ['PGE-' + 'B2S.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'B2S.empty']: { emptyState: { title: 'B2b Sla Dashboard Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from b2b.tsx
  ['PGE-CAH']: {
                ['PGE-' + 'CAH.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'CAH.empty']: { emptyState: { title: 'Corporate Account Hierarchy Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from b2b.tsx
  ['PGE-DPP']: {
                ['PGE-' + 'DPP.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'DPP.empty']: { emptyState: { title: 'Discharge Planner Portal Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from b2b.tsx
  ['PGE-FLT']: {
                ['PGE-' + 'FLT.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'FLT.empty']: { emptyState: { title: 'Facility Lunch Tracker Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from b2b.tsx
  ['PGE-PRT']: {
                ['PGE-' + 'PRT.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'PRT.empty']: { emptyState: { title: 'Physician Roi Tracker Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from b2b.tsx
  ['PGE-PDS']: {
                ['PGE-' + 'PDS.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'PDS.empty']: { emptyState: { title: 'Post Discharge Success Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from b2b.tsx
  ['PGE-RSH']: {
                ['PGE-' + 'RSH.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'RSH.empty']: { emptyState: { title: 'Referral Source Heatmap Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from brand.tsx
  ['PGE-ARA']: {
                ['PGE-' + 'ARA.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'ARA.empty']: { emptyState: { title: 'Automated Review Asker Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from brand.tsx
  ['PGE-BAL']: {
                ['PGE-' + 'BAL.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'BAL.empty']: { emptyState: { title: 'Brand Asset Library Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from brand.tsx
  ['PGE-CKH']: {
                ['PGE-' + 'CKH.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'CKH.empty']: { emptyState: { title: 'Competitor Keyword Hijacker Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from brand.tsx
  ['PGE-CCT']: {
                ['PGE-' + 'CCT.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'CCT.empty']: { emptyState: { title: 'Crisis Comms Triage Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from brand.tsx
  ['PGE-GBS']: {
                ['PGE-' + 'GBS.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'GBS.empty']: { emptyState: { title: 'Google Business Sync Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from brand.tsx
  ['PGE-LSR']: {
                ['PGE-' + 'LSR.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'LSR.empty']: { emptyState: { title: 'Local Seo Rank Tracker Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from brand.tsx
  ['PGE-RSA']: {
                ['PGE-' + 'RSA.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'RSA.empty']: { emptyState: { title: 'Review Sentiment Analyzer Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from data.tsx
  ['PGE-GFA']: {
                ['PGE-' + 'GFA.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'GFA.empty']: { emptyState: { title: 'Geo Fenced Ad Dashboard Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from pipeline.tsx
  ['PGE-COC']: {
                ['PGE-' + 'COC.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'COC.empty']: { emptyState: { title: 'Cost Of Care Calculator Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from pipeline.tsx
  ['PGE-LPA']: {
                ['PGE-' + 'LPA.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'LPA.empty']: { emptyState: { title: 'Landing Page Ab Tester Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from pipeline.tsx
  ['PGE-LCF']: {
                ['PGE-' + 'LCF.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'LCF.empty']: { emptyState: { title: 'Lead Conversion Funnel Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from pipeline.tsx
  ['PGE-LCH']: {
                ['PGE-' + 'LCH.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'LCH.empty']: { emptyState: { title: 'Live Chat Handover Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from pipeline.tsx
  ['PGE-RPT']: {
                ['PGE-' + 'RPT.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'RPT.empty']: { emptyState: { title: 'Referral Program Tracker Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from retention.tsx
  ['PGE-CRP']: {
                ['PGE-' + 'CRP.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'CRP.empty']: { emptyState: { title: 'Churn Risk Predictor Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from retention.tsx
  ['PGE-DES']: {
                ['PGE-' + 'DES.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'DES.empty']: { emptyState: { title: 'Drip Email Sequence Builder Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from retention.tsx
  ['PGE-ERB']: {
                ['PGE-' + 'ERB.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'ERB.empty']: { emptyState: { title: 'Event Registration Builder Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from retention.tsx
  ['PGE-MRA']: {
                ['PGE-' + 'MRA.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'MRA.empty']: { emptyState: { title: 'Marketing Revenue Attribution Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from retention.tsx
  ['PGE-NSD']: {
                ['PGE-' + 'NSD.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'NSD.empty']: { emptyState: { title: 'Newsletter Subscriber Db Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from retention.tsx
  ['PGE-PDE']: {
                ['PGE-' + 'PDE.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'PDE.empty']: { emptyState: { title: 'Promotional Discount Engine Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from seo.tsx
  ['PGE-BCC']: {
                ['PGE-' + 'BCC.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'BCC.empty']: { emptyState: { title: 'Blog Content Calendar Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from seo.tsx
  ['PGE-CSC']: {
                ['PGE-' + 'CSC.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'CSC.empty']: { emptyState: { title: 'Caregiver Spotlight Creator Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from seo.tsx
  ['PGE-CEH']: {
                ['PGE-' + 'CEH.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'CEH.empty']: { emptyState: { title: 'Content Engagement Heatmap Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from seo.tsx
  ['PGE-KCM']: {
                ['PGE-' + 'KCM.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'KCM.empty']: { emptyState: { title: 'Keyword Cannibalization Monitor Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from seo.tsx
  ['PGE-SCW']: {
                ['PGE-' + 'SCW.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'SCW.empty']: { emptyState: { title: 'Seo Core Web Vitals Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from seo.tsx
  ['PGE-TRT']: {
                ['PGE-' + 'TRT.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'TRT.empty']: { emptyState: { title: 'Testimonial Release Tracker Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from seo.tsx
  ['PGE-TSV']: {
                ['PGE-' + 'TSV.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'TSV.empty']: { emptyState: { title: 'Traffic Source Visualizer Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from seo.tsx
  ['PGE-UPB']: {
                ['PGE-' + 'UPB.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'UPB.empty']: { emptyState: { title: 'Utm Parameter Builder Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from syndication.tsx
  ['PGE-SMC']: {
                ['PGE-' + 'SMC.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'SMC.empty']: { emptyState: { title: 'Social Media Credential Vault Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from territory.tsx
  ['PGE-STM']: {
                ['PGE-' + 'STM.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'STM.empty']: { emptyState: { title: 'Sales Territory Map Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from audit.tsx
  ['PGE-DSA']: {
                ['PGE-' + 'DSA.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'DSA.empty']: { emptyState: { title: 'Database Schema Audit Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from audit.tsx
  ['PGE-EA']: {
                ['PGE-' + 'EA.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'EA.empty']: { emptyState: { title: 'Environment Audit Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from audit.tsx
  ['PG-207']: {
                'PG-207.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-207.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from audit.tsx
  ['PGE-RIC']: {
                ['PGE-' + 'RIC.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'RIC.empty']: { emptyState: { title: 'Registry Integrity Check Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from audit.tsx
  ['PGE-RB']: {
                ['PGE-' + 'RB.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'RB.empty']: { emptyState: { title: 'Response Bot Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from audit.tsx
  ['PGE-TAP']: {
                ['PGE-' + 'TAP.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'TAP.empty']: { emptyState: { title: 'Technical Audit Portal Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from builds.tsx
  ['PG-610']: {
                'PG-610.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-610.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from dashboard.tsx
  ['SM']: {
                'SM.stats': { kpiCards: [
                    { label: 'API Uptime', value: '99.97%', color: 'var(--pc-success)' },
                    { label: 'Active Endpoints', value: 142, color: 'var(--pc-primary)' },
                    { label: 'Error Rate', value: '0.3%', color: 'var(--pc-warning)' },
                    { label: 'Deploy #', value: 39, color: '#8B5CF6' },
                ]},
                'SM.health': { statusCards: { items: [
                    { label: 'worker-api', value: 'Healthy', description: '142 endpoints, 0 errors', icon: 'Activity', color: 'green' },
                    { label: 'web-admin', value: 'Healthy', description: '94 pages, 18 section types', icon: 'Activity', color: 'green' },
                    { label: 'Database', value: 'Active', description: 'Supabase — 47 models', icon: 'Activity', color: 'green' },
                    { label: 'Auth', value: 'Operational', description: 'Firebase — Deadlock patched', icon: 'Activity', color: 'green' },
                ]} },
                'SM.roadmap': { table: { columns: [
                    { key: 'sprint', label: 'Sprint' }, { key: 'feature', label: 'Feature' },
                    { key: 'status', label: 'Status' }, { key: 'owner', label: 'Owner' },
                ], rows: [
                    { sprint: 'S12', feature: 'Section-based PageTemplate', status: '✅ Complete', owner: 'Platform' },
                    { sprint: 'S12', feature: 'Old sub-file cleanup', status: '✅ Complete', owner: 'Platform' },
                    { sprint: 'S13', feature: 'Multi-currency ledger', status: '🟡 In Progress', owner: 'Finance' },
                    { sprint: 'S13', feature: 'Mobile PWA offline', status: '🔲 Planned', owner: 'Mobile' },
                ]}},
            },

  // Extracted from developer-kb.tsx
  ['PG-880']: {
                'PG-880.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-880.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from developer.tsx
  ['PG-695']: {
                'PG-695.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-695.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from e2e-runner.tsx
  ['PG-205']: {
                'PG-205.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-205.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from flows.tsx
  ['PGE-RFP']: {
                ['PGE-' + 'RFP.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'RFP.empty']: { emptyState: { title: 'Role Flows Page Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from flows.tsx
  ['PGE-SAM']: {
                ['PGE-' + 'SAM.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'SAM.empty']: { emptyState: { title: 'Step Audit Modal Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from impersonate.tsx
  ['PGE-IT']: {
                ['PGE-' + 'IT.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'IT.empty']: { emptyState: { title: 'Impersonation Tool Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from locales.tsx
  ['PG-233']: {
                'PG-233.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-233.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from monitoring.tsx
  ['PGE-SHM']: {
                ['PGE-' + 'SHM.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'SHM.empty']: { emptyState: { title: 'System Health Monitor Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from performance.tsx
  ['PG-128']: {
                'PG-128.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-128.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from property.tsx
  ['PG-454']: {
                'PG-454.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-454.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from repair.tsx
  ['PGE-RAR']: {
                ['PGE-' + 'RAR.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'RAR.empty']: { emptyState: { title: 'Registry Auto Repair Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from scans.tsx
  ['PG-738']: {
                'PG-738.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-738.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from testing.tsx
  ['PGE-AEH']: {
                ['PGE-' + 'AEH.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'AEH.empty']: { emptyState: { title: 'Api Endpoints Hub Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from theme.tsx
  ['PG-423']: {
                'PG-423.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-423.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from usage.tsx
  ['PG-128_alt']: {
                'PG-128.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-128.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from sla-monitoring.tsx
  ['PG-830']: {
                'PG-830.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-830.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from index.tsx
  ['PGE-RSD']: {
                ['PGE-' + 'RSD.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'RSD.empty']: { emptyState: { title: 'Risk Surveillance Dashboard Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from super-admin.tsx
  ['PG-599']: {
                'PG-599.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-599.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from tenants.tsx
  ['PG-686']: {
                'PG-686.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-686.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from error.tsx
  ['COMPLEX_KEY_215_411003']: {
                'mod.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'System Status', value: '100%', color: 'var(--pc-success)' },
                ]},
                'mod.body': { emptyState: { 
                    title: 'Not Found', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from error.tsx
  ['COMPLEX_KEY_216_768759']: {
                'mod.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'System Status', value: '100%', color: 'var(--pc-success)' },
                ]},
                'mod.body': { emptyState: { 
                    title: 'Server Error', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from error.tsx
  ['COMPLEX_KEY_217_811881']: {
                'mod.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'System Status', value: '100%', color: 'var(--pc-success)' },
                ]},
                'mod.body': { emptyState: { 
                    title: 'Unauthorized', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from messaging.tsx
  ['PG-736']: {
                'PG-736.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-736.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from pages.tsx
  ['PGE-DP']: {
                ['PGE-' + 'DP.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'DP.empty']: { emptyState: { title: 'Dev Preview Data', description: 'This section is currently using template placeholders.' } }
            },

  // Extracted from pages.tsx
  ['COMPLEX_KEY_220_58064']: {
                'mod.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'System Status', value: '100%', color: 'var(--pc-success)' },
                ]},
                'mod.body': { emptyState: { 
                    title: 'Marketing Showcase', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from pages.tsx
  ['PG-178']: {
                'PG-178.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-178.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from profile.tsx
  ['PG-815']: {
                'PG-815.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-815.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from support-hub.tsx
  ['PG-150']: {
                'PG-150.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-150.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from support-ticket.tsx
  ['PG-435']: {
                'PG-435.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-435.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from training.tsx
  ['PG-472']: {
                'PG-472.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-472.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from visit-completion.tsx
  ['PG-330']: {
                'PG-330.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-330.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from visit-details.tsx
  ['PG-190']: {
                'PG-190.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-190.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            },

  // Extracted from ops.tsx
  ['H20']: {
                'H20.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from ops.tsx
  ['T64']: {
                'T64.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from ops.tsx
  ['T65']: {
                'T65.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from index.tsx
  ['D18']: {
                'D18.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from sign-off.tsx
  ['T42']: {
                'T42.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from treatments.tsx
  ['L21']: {
                'L21.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from billing.tsx
  ['H10']: {
                'H10.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from bookings.tsx
  ['L14']: {
                'L14.stats': { kpiCards: [
                    { label: 'Upcoming', value: 3, color: 'var(--pc-primary)' },
                    { label: 'Completed (MTD)', value: 12, color: 'var(--pc-success)' },
                    { label: 'Cancelled', value: 1, color: 'var(--pc-error, #EF4444)' },
                    { label: 'Pending Requests', value: 1, color: 'var(--pc-warning)' },
                ]},
                'L14.bookings': { table: { columns: [
                    { key: 'date', label: 'Date' }, { key: 'time', label: 'Time' },
                    { key: 'caregiver', label: 'Caregiver' }, { key: 'service', label: 'Service' },
                    { key: 'status', label: 'Status' },
                ], rows: [
                    { date: 'Mar 17', time: '2:00 PM', caregiver: 'Sarah P.', service: 'Personal Care', status: '🟢 Confirmed' },
                    { date: 'Mar 18', time: '10:00 AM', caregiver: 'Mike R.', service: 'Companionship', status: '🟢 Confirmed' },
                    { date: 'Mar 20', time: '9:00 AM', caregiver: 'TBD', service: 'ADL Support', status: '🟡 Pending' },
                ]}},
            },

  // Extracted from dashboard.tsx
  ['D8']: {
                'D8.stats': { kpiCards: [
                    { label: 'Next Visit', value: 'Today 2 PM', color: 'var(--pc-primary)' },
                    { label: 'Care Hours (MTD)', value: 42,  color: 'var(--pc-success)' },
                    { label: 'Funding Balance', value: '$3,200', color: '#8B5CF6' },
                    { label: 'Care Team', value: '4 Members', color: '#F59E0B' },
                ]},
                'D8.upcoming': { table: { columns: [
                    { key: 'date', label: 'Date' }, { key: 'caregiver', label: 'Caregiver' },
                    { key: 'service', label: 'Service' }, { key: 'time', label: 'Time' },
                ], rows: [
                    { date: 'Today', caregiver: 'Sarah P.', service: 'Personal Care', time: '2:00 PM — 4:00 PM' },
                    { date: 'Tomorrow', caregiver: 'Mike R.', service: 'Companionship', time: '10:00 AM — 12:00 PM' },
                    { date: 'Mar 19', caregiver: 'Lisa T.', service: 'ADL Support', time: '9:00 AM — 11:00 AM' },
                ]}},
                'D8.journey': { statusCards: { items: [
                    { label: 'Care Plan', value: 'Active', description: 'Reviewed Jan 2026', icon: 'Activity', color: 'green' },
                    { label: 'Assessments', value: 'Up to Date', description: 'Next due Apr 2026', icon: 'Activity', color: 'green' },
                    { label: 'Telehealth', value: 'Available', description: 'Dr. Chen — Click to join', icon: 'Activity', color: 'blue' },
                ]} },
            },

  // Extracted from engagement.tsx
  ['H17']: {
                'H17.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from family.tsx
  ['P1']: {
                'P1.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from feedback.tsx
  ['F16']: {
                'F16.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from medical.tsx
  ['R5']: {
                'R5.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from request-booking.tsx
  ['F17']: {
                'F17.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from services.tsx
  ['T34']: {
                'T34.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from support.tsx
  ['T35']: {
                'T35.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from support.tsx
  ['T37']: {
                'T37.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from team.tsx
  ['T36']: {
                'T36.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from fleet.tsx
  ['T40']: {
                'T40.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from hub.tsx
  ['H18']: {
                'H18.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from map.tsx
  ['T38']: {
                'T38.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from shift-swap.tsx
  ['T41']: {
                'T41.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from sos.tsx
  ['T39']: {
                'T39.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from waitlist.tsx
  ['L20']: {
                'L20.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from dashboard.tsx
  ['FAM']: {
                'FAM.stats': { kpiCards: [
                    { label: 'Next Visit', value: 'Today 2 PM', color: 'var(--pc-primary)' },
                    { label: 'Monthly Hours', value: 38,  color: 'var(--pc-success)' },
                    { label: 'Balance Due', value: '$45.00', color: 'var(--pc-warning)' },
                    { label: 'Care Updates', value: 3,  color: '#8B5CF6' },
                ]},
                'FAM.updates': { table: { columns: [
                    { key: 'date', label: 'Date' }, { key: 'caregiver', label: 'Caregiver' },
                    { key: 'update', label: 'Update' }, { key: 'mood', label: 'Mood' },
                ], rows: [
                    { date: 'Today', caregiver: 'Sarah P.', update: 'Had a great morning walk, ate full breakfast', mood: '😊 Happy' },
                    { date: 'Yesterday', caregiver: 'Mike R.', update: 'Completed physio exercises, watched TV together', mood: '😌 Calm' },
                    { date: 'Mar 14', caregiver: 'Lisa T.', update: 'Slight fatigue, rested after lunch', mood: '😐 Neutral' },
                ]}},
            },

  // Extracted from index.tsx
  ['D12']: {
                'D12.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from index.tsx
  ['H13']: {
                'H13.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from compliance.tsx
  ['T25']: {
                'T25.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from daily-entry.tsx
  ['T20']: {
                'T20.stats': { kpiCards: [
                    { label: 'Entries Today', value: 5, color: 'var(--pc-primary)' },
                    { label: 'Unsigned', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Avg Duration', value: '12 min', color: 'var(--pc-success)' },
                    { label: 'Compliance', value: '96%', color: '#8B5CF6' },
                ]},
                'T20.entries': { table: { columns: [
                    { key: 'client', label: 'Client' }, { key: 'date', label: 'Date' },
                    { key: 'adl', label: 'ADLs Recorded' }, { key: 'vitals', label: 'Vitals' },
                    { key: 'status', label: 'Status' },
                ], rows: [
                    { client: 'J. Martinez', date: 'Today', adl: '✅ Bathing, Dressing, Grooming', vitals: 'BP: 120/80', status: '🟢 Signed' },
                    { client: 'R. Kim', date: 'Today', adl: '✅ Mobility, Eating', vitals: 'Temp: 36.8°C', status: '🟢 Signed' },
                    { client: 'S. Thompson', date: 'Today', adl: '⚠️ Partial — Needs review', vitals: 'HR: 92', status: '🟡 Unsigned' },
                ]}},
            },

  // Extracted from dashboard.tsx
  ['D7_alt']: {
                'D7.stats': { kpiCards: [
                    { label: 'Active Staff', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Visits Today', value: 47, color: 'var(--pc-success)' },
                    { label: 'Overtime Alerts', value: 3, color: 'var(--pc-warning)' },
                    { label: 'Branch Margin', value: '18.2%', color: '#8B5CF6' },
                ]},
                'D7.timeline': { table: { columns: [
                    { key: 'time', label: 'Time' }, { key: 'event', label: 'Event' },
                    { key: 'staff', label: 'Staff' }, { key: 'status', label: 'Status' },
                ], rows: [
                    { time: '07:00', event: 'Shift Start — Morning Block', staff: '12 PSWs', status: '🟢 On Track' },
                    { time: '09:30', event: 'Late Check-In Alert', staff: 'S. Patel', status: '🟡 5 min late' },
                    { time: '11:00', event: 'Shift Swap Approved', staff: 'J. Lee ↔ M. Kim', status: '✅ Completed' },
                ]}},
            },

  // Extracted from documents.tsx
  ['H27']: {
                'H27.stats': { kpiCards: [
                    { label: 'Total Documents', value: 247, color: 'var(--pc-primary)' },
                    { label: 'Pending Signatures', value: 12, color: 'var(--pc-warning)' },
                    { label: 'Completed This Month', value: 38, color: 'var(--pc-success)' },
                    { label: 'Expired', value: 3, color: 'var(--pc-error, #ef4444)' },
                ]},
                'H27.pending-list': { table: { columns: docCols, rows: documents } },
                'H27.completed': { cardGrid: { items: templates, columns: 3 } },
            },

  // Extracted from engagement.tsx
  ['H25']: {
                'H25.stats': { kpiCards: [
                    { label: 'Active PSWs', value: 48, icon: '👥', color: 'var(--pc-primary)' },
                    { label: 'Avg Score', value: '2,050', icon: '📊', color: 'var(--pc-success)' },
                    { label: 'Badges Issued', value: 156, icon: '🎖️', color: 'var(--pc-warning)' },
                    { label: 'Active Challenges', value: 3, icon: '🎯', color: '#7C3AED' },
                    { label: 'Retention Rate', value: '94%', icon: '💎', color: 'var(--pc-info, #2563EB)' },
                ]},
                'H25.tabs': { tabs: {
                    tabs: [
                        { id: 'leaderboard', label: '🏆 Leaderboard', count: 8 },
                        { id: 'badges', label: '🎖️ Badges', count: 8 },
                        { id: 'challenges', label: '🎯 Challenges', count: 3 },
                        { id: 'rewards', label: '🎁 Rewards' },
                    ],
                    activeTab, onTabChange: setActiveTab,
                }},
                ...tabContent[activeTab],
            },

  // Extracted from evaluations.tsx
  ['L13']: {
                'L13.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from finance.tsx
  ['D9']: {
                'D9.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from finance.tsx
  ['T24']: {
                'T24.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from hr.tsx
  ['L23']: {
                'L23.stats': { kpiCards: [
                    { label: 'Total Reviews', value: 5, color: 'var(--pc-primary)' },
                    { label: 'Completed', value: 2, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Avg Score', value: '4.3', color: 'var(--pc-success)' },
                ]},
                'L23.review-table': { table: { columns: reviewCols, rows: reviews } },
            },

  // Extracted from iot.tsx
  ['H26']: {
                'H26.device-stats': { kpiCards: [
                    { label: 'Connected Devices', value: 6, icon: '📱', color: 'var(--pc-primary)' },
                    { label: 'Events Today', value: 142, icon: '📊', color: 'var(--pc-info, #2563EB)' },
                    { label: 'Active Alerts', value: 6, icon: '🔔', color: 'var(--pc-error, #ef4444)' },
                    { label: 'Avg Battery', value: '63%', icon: '🔋', color: 'var(--pc-warning)' },
                    { label: 'Uptime', value: '99.2%', icon: '✅', color: 'var(--pc-success)' },
                ]},
                'H26.device-table': { table: { columns: deviceCols, rows: devices } },
                'H26.alert-panel': { alerts: [
                    { level: 'danger' as const, message: 'Glucose: 210 mg/dL — high alert (Helen Kowalski)', time: '10:25 AM' },
                    { level: 'danger' as const, message: 'Dose missed — 10:00 AM Metformin (Yuki Tanaka)', time: '10:15 AM' },
                    { level: 'warning' as const, message: 'BP reading: 142/88 — elevated (Robert Davies)', time: '10:38 AM' },
                    { level: 'warning' as const, message: 'BP reading: 138/85 — borderline (Robert Davies)', time: '9:30 AM' },
                    { level: 'info' as const, message: 'Motion detected — normal activity (Margaret Chen)', time: '10:42 AM' },
                    { level: 'info' as const, message: 'Sleep quality: 7.2/10 — good (Sarah O\'Malley)', time: '10:10 AM' },
                ]},
            },

  // Extracted from operations.tsx
  ['H12']: {
                'H12.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from pages.tsx
  ['D10']: {
                'D10.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from performance.tsx
  ['T23']: {
                'T23.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from portfolio.tsx
  ['T19']: {
                'T19.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from service-review.tsx
  ['T21']: {
                'T21.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from surveys.tsx
  ['T22']: {
                'T22.stats': { kpiCards: [
                    { label: 'Active Surveys', value: 3, color: 'var(--pc-primary)' },
                    { label: 'Responses (MTD)', value: 128, color: 'var(--pc-success)' },
                    { label: 'Avg Satisfaction', value: '4.2/5', color: '#8B5CF6' },
                    { label: 'Completion Rate', value: '76%', color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from training.tsx
  ['H29']: {
                'H29.stats': { kpiCards: [
                    { label: 'Active Courses', value: 7, color: 'var(--pc-primary)' },
                    { label: 'Total Enrollments', value: 287, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Completion Rate', value: '86%', color: 'var(--pc-success)' },
                    { label: 'Expiring Certs', value: 3, color: 'var(--pc-warning)' },
                    { label: 'Avg Rating', value: '4.6 ⭐', color: 'var(--pc-success)' },
                ]},
                'H29.module-grid': { tabs: {
                    tabs: [
                        { id: 'courses', label: '📚 Courses', count: 7 },
                        { id: 'progress', label: '🏆 Certifications', count: 4 },
                    ],
                    activeTab: tab, onTabChange: setTab,
                }},
                ...tabContent[tab],
            },

  // Extracted from index.tsx
  ['D11']: {
                'D11.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from availability.tsx
  ['F15']: {
                'F15.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from credentials.tsx
  ['H14']: {
                'H14.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from dashboard.tsx
  ['D14']: {
                'D14.stats': { kpiCards: [
                    { label: 'Upcoming Shifts', value: 3, color: 'var(--pc-primary)' },
                    { label: 'Hours This Week', value: 28.5,  color: 'var(--pc-success)' },
                    { label: 'Reliability Streak', value: '14 days', color: '#8B5CF6' },
                    { label: 'Projected Earnings', value: '$1,240', color: '#F59E0B' },
                ]},
                'D14.shifts': { table: { columns: [
                    { key: 'client', label: 'Client' }, { key: 'time', label: 'Time' },
                    { key: 'type', label: 'Visit Type' }, { key: 'status', label: 'Status' },
                ], rows: [
                    { client: 'Jane M.', time: 'Today 2:00 PM', type: 'Personal Care', status: '🟢 Confirmed' },
                    { client: 'Robert K.', time: 'Today 5:00 PM', type: 'Companionship', status: '🟢 Confirmed' },
                    { client: 'Maria L.', time: 'Tomorrow 9:00 AM', type: 'ADL Support', status: '🟡 Pending' },
                ]}},
                'D14.compliance': { statusCards: { items: [
                    { label: 'CPR Certification', value: 'Valid', description: 'Expires Dec 2026', icon: 'Activity', color: 'green' },
                    { label: 'TB Test', value: 'Current', description: 'Due Mar 2027', icon: 'Activity', color: 'green' },
                    { label: 'First Aid', value: 'Expiring Soon', description: 'Expires Apr 2026', icon: 'Activity', color: 'yellow' },
                ]} },
            },

  // Extracted from earnings.tsx
  ['R3']: {
                'R3.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from expenses.tsx
  ['F14']: {
                'F14.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from feed.tsx
  ['T27']: {
                'T27.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from guide.tsx
  ['G1']: {
                'G1.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from handover.tsx
  ['F13']: {
                'F13.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from mileage.tsx
  ['T28']: {
                'T28.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from OpenShifts.tsx
  ['L17']: {
                'L17.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from OpenShifts.tsx
  ['T60']: {
                'T60.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from payouts.tsx
  ['R4']: {
                'R4.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from schedule.tsx
  ['L16']: {
                'L16.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from schedule.tsx
  ['T61']: {
                'T61.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from schedule.tsx
  ['T62']: {
                'T62.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from shift-confirmation.tsx
  ['T26']: {
                'T26.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from training.tsx
  ['H15']: {
                'H15.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from index.tsx
  ['D13']: {
                'D13.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from assessments.tsx
  ['L18']: {
                'L18.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from audit.tsx
  ['T30']: {
                'T30.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from care-plans.tsx
  ['T29']: {
                'T29.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from dashboard.tsx
  ['D15']: {
                'D15.stats': { kpiCards: [
                    { label: 'Active Patients', value: 18, color: 'var(--pc-primary)' },
                    { label: 'Assessments Due', value: 4, color: 'var(--pc-warning)' },
                    { label: 'Delegations Active', value: 7, color: 'var(--pc-success)' },
                    { label: 'Critical Alerts', value: 1, color: 'var(--pc-error, #EF4444)' },
                ]},
                'D15.patients': { table: { columns: [
                    { key: 'patient', label: 'Patient' }, { key: 'assessment', label: 'Next Assessment' },
                    { key: 'carePlan', label: 'Care Plan' }, { key: 'meds', label: 'MAR Status' },
                    { key: 'alert', label: 'Alert' },
                ], rows: [
                    { patient: 'E. Rodriguez', assessment: 'Today', carePlan: '✅ Current', meds: '🟢 Compliant', alert: '—' },
                    { patient: 'K. Patel', assessment: 'Tomorrow', carePlan: '✅ Current', meds: '🟡 1 Missed', alert: '⚠️ Follow-up' },
                    { patient: 'W. Johnson', assessment: 'Overdue', carePlan: '🔄 Renewal', meds: '🟢 Compliant', alert: '🔴 Urgent' },
                ]}},
                'D15.compliance': { statusCards: { items: [
                    { label: 'Documentation', value: '94%', description: '18/19 entries complete', icon: 'Activity', color: 'green' },
                    { label: 'Delegation Audits', value: 'Passed', description: 'Last audit: Mar 12', icon: 'Activity', color: 'green' },
                    { label: 'Wound Assessments', value: '2 Due', description: 'Next: Today 3 PM', icon: 'Activity', color: 'yellow' },
                ]} },
            },

  // Extracted from mar.tsx
  ['D16']: {
                'D16.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from mar.tsx
  ['T31']: {
                'T31.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from rai.tsx
  ['L19']: {
                'L19.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from rai.tsx
  ['T33']: {
                'T33.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from schedule.tsx
  ['T63']: {
                'T63.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from supervision.tsx
  ['H16']: {
                'H16.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from wound-care.tsx
  ['WC']: {
                'WC.stats': { kpiCards: [
                    { label: 'Active Wounds', value: 8, color: 'var(--pc-primary)' },
                    { label: 'Healing On Track', value: 6, color: 'var(--pc-success)' },
                    { label: 'Needs Attention', value: 2, color: 'var(--pc-warning)' },
                    { label: 'Assessments Due', value: 4, color: '#8B5CF6' },
                ]},
                'WC.wounds': { table: { columns: [
                    { key: 'client', label: 'Client' }, { key: 'type', label: 'Wound Type' },
                    { key: 'location', label: 'Location' }, { key: 'stage', label: 'Stage' },
                    { key: 'progress', label: 'Progress' },
                ], rows: [
                    { client: 'A. Chen', type: 'Pressure Ulcer', location: 'Sacrum', stage: 'Stage II', progress: '🟢 Healing' },
                    { client: 'M. Garcia', type: 'Surgical', location: 'L Knee', stage: 'Post-Op', progress: '🟢 On Track' },
                    { client: 'J. Williams', type: 'Diabetic Ulcer', location: 'R Foot', stage: 'Stage III', progress: '🟡 Slow' },
                ]}},
            },

  // Extracted from wound-care.tsx
  ['D17']: {
                'D17.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from wound-care.tsx
  ['T32']: {
                'T32.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from pages.tsx
  ['T47']: {
                'T47.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from dashboard.tsx
  ['D19']: {
                'D19.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from messages.tsx
  ['T44']: {
                'T44.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from operations.tsx
  ['T45']: {
                'T45.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from operations.tsx
  ['T46']: {
                'T46.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

  // Extracted from tasks.tsx
  ['T43']: {
                'T43.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            },

};
