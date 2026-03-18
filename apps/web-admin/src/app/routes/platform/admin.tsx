const { RouteRegistry, ApiRegistry, ContentRegistry, ThemeRegistry, PageRegistry, FormRegistry } = AdminRegistry;

import { useRegistryQuery } from "../../../shared/hooks/useRegistryQuery";
import { apiClient } from "../../../shared/utils/apiClient";
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";
import AppLayout from "@/shared/components/layout/AppLayout";
import { TableColumn, TabItem } from "@/shared/components/sections";
import { PageTemplate } from "@/shared/components/ui/PageTemplate";
import { useDialog } from "@/shared/hooks/useDialog";
import { useToast } from "@/shared/hooks/useToast";
import RequireRole from "@/shared/rbac/RequireRole";
import { useQueryClient } from "@tanstack/react-query";
import { FileText, Search, LayoutGrid, Filter, BarChart3, ClipboardList, Layers, Compass, Wand2, Wrench, Globe, BookOpen, AlertTriangle, Network, List } from "lucide-react";
import { AdminRegistry, FormEntry, PageType, PageEntry, MasterEntry } from "prime-care-shared";
import React, { lazy, useState, useMemo, useEffect } from "react";
import { useTranslation } from "react-i18next";
import { Route, useNavigate, useSearchParams } from "react-router";

// --- Extracted from AdminRoutes.tsx ---
// Admin secondary pages (Lazy loaded)
// Admin Pages (Lazy loaded)
// NEW PREMIUM PAGES (Session Sprint 3-6)
// --- Extracted from admission.tsx ---
// Barrel re-export — identity file: F6-ClientAdmission.tsx
// removed broken export: export { default } from './F6-ClientAdmission';


// --- Merged from F6-ClientAdmission.tsx ---
// PAGE IDENTITY: F6 · Client Admission

export function ClientAdmission() {
    return (
        <PageTemplate pageId="F6" title="📋 Client Admission" subtitle="New client intake workflow — referral, demographics, assessment & service plan"
            sectionData={PageSectionRegistry['F6']}
        />
    );
}

// --- Extracted from ai.tsx ---
export function PredictiveAnalytics() {
    const [tab, setTab] = useState('risk');
    const tabs: TabItem[] = [
        { id: 'risk', label: '🎯 Risk Scoring', count: 12 },
        { id: 'trends', label: '📈 Trend Forecast' },
        { id: 'anomaly', label: '⚠️ Anomaly Detection', count: 3 },
        { id: 'correlation', label: '🔗 Correlation Matrix' },
    ];

    const tabContent: Record<string, Record<string, any>> = {
        risk: { 'T52.content': { chart: { title: 'Client Risk Scores', type: 'horizontal-bar', data: [
            { label: 'Low Risk', value: 67, color: '#10B981' },
            { label: 'Medium Risk', value: 23, color: '#F59E0B' },
            { label: 'High Risk', value: 8, color: '#EF4444' },
            { label: 'Critical', value: 2, color: '#DC2626' },
        ]}}},
        trends: { 'T52.content': { chart: { title: 'Visit Demand Forecast (Next 30 Days)', type: 'bar', data: [
            { label: 'W1', value: 340 }, { label: 'W2', value: 380 },
            { label: 'W3', value: 365 }, { label: 'W4', value: 410 },
        ]}}},
        anomaly: { 'T52.content': { feed: { title: 'Detected Anomalies', items: [
            { icon: '🔴', title: 'PSW-032: Clock-in outside service area 3x this week', time: '1 hr ago', level: 'danger' as const },
            { icon: '🟡', title: 'Client Chen: Visit duration 3.2σ above mean', time: '3 hrs ago', level: 'warning' as const },
            { icon: '🟡', title: 'PSW-018: 12 consecutive missed signatures', time: '1 day ago', level: 'warning' as const },
        ]}}},
        correlation: { 'T52.content': { chart: { title: 'Factor Correlation Strength', type: 'donut', data: [
            { label: 'Visit Length ↔ Satisfaction', value: 34 },
            { label: 'Training ↔ Compliance', value: 28 },
            { label: 'Workload ↔ Burnout', value: 22 },
            { label: 'Distance ↔ Punctuality', value: 16 },
        ]}}},
    };

    return (
        <PageTemplate
            pageId="T52"
            title="📈 Predictive Analytics"
            subtitle="AI-powered risk scoring, trend forecasting, anomaly detection & correlation analysis"
            actionPageId="admin.predictive-analytics"
            sectionData={PageSectionRegistry['T52']}
        />
    );
}

// --- Merged from T53-ChurnRisk.tsx ---
// ================================================================
// PAGE IDENTITY: T53 · Churn Risk
// Type: Tool | Owner: admin | Registry: T53
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function ChurnRisk() {
    return (
        <PageTemplate
            pageId="T53"
            title="⚠️ Churn Risk Analysis"
            subtitle="AI-predicted client attrition risk with actionable intervention recommendations"
            actionPageId="admin.churn-risk"
            sectionData={PageSectionRegistry['T53']}
        />
    );
}

// --- Merged from T54-VisitOptimization.tsx ---
// ================================================================
// PAGE IDENTITY: T54 · Visit Optimization
// Type: Tool | Owner: admin | Registry: T54
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function Visit_xxxOptimization() {
    return (
        <PageTemplate
            pageId="T54"
            title="🗺️ Visit Optimization"
            subtitle="AI-powered route clustering, schedule optimization & PSW-client matching"
            actionPageId="admin.visit-optimization"
            sectionData={PageSectionRegistry['T54']}
        />
    );
}

// --- Merged from T55-SentimentAnalysis.tsx ---
// ================================================================
// PAGE IDENTITY: T55 · Sentiment Analysis
// Type: Tool | Owner: admin | Registry: T55
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function SentimentAnalysis() {
    return (
        <PageTemplate
            pageId="T55"
            title="💬 Sentiment Analysis"
            subtitle="AI-powered sentiment tracking from surveys, calls, and feedback forms"
            actionPageId="admin.sentiment-analysis"
            sectionData={PageSectionRegistry['T55']}
        />
    );
}

// --- Extracted from audit-export.tsx ---
// --- Merged from R10-ComplianceExport.tsx ---
// PAGE IDENTITY: R10 · Compliance Export

export function ComplianceExport() {
    return (
        <PageTemplate pageId="R10" title="📋 Compliance Export" subtitle="Generate compliance reports for HIPAA, PIPEDA, OHSA & accreditation"
            sectionData={PageSectionRegistry['R10']}
        />
    );
}

// --- Merged from R13-RegulatoryExport.tsx ---
// PAGE IDENTITY: R13 · Regulatory Export

export function RegulatoryExport() {
    return (
        <PageTemplate pageId="R13" title="🏛️ Regulatory Export" subtitle="Government & regulatory body submissions — CRA, WSIB, MOH, ESA"
            sectionData={PageSectionRegistry['R13']}
        />
    );
}

// --- Merged from R9-AuditDownload.tsx ---
// PAGE IDENTITY: R9 · Audit Download | R10 · Compliance Export | R13 · Regulatory Export

export function AuditDownload() {
    return (
        <PageTemplate pageId="R9" title="📥 Audit Download" subtitle="Download audit trail exports in CSV, PDF & XBRL formats"
            sectionData={PageSectionRegistry['R9']}
        />
    );
}

// --- Extracted from audits.tsx ---
// Re-export from identity file: L6-AuditLogs.tsx
// removed broken export: export { default } from './L6-AuditLogs';


// --- Merged from L6-AuditLogs.tsx ---
// ================================================================
// PAGE IDENTITY: L6 · Audit Logs
// Type: List | Owner: admin
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function AuditLogs() {
    return (
        <PageTemplate pageId="L6" title="📋 Audit Logs" subtitle="Complete audit trail of all platform actions"
            actionPageId="admin.audit-logs"
            sectionData={PageSectionRegistry['L6']}
        />
    );
}

// --- Extracted from authorizations.tsx ---
const cols_2: TableColumn[] = [
    { key: 'client', label: 'Client' }, { key: 'payer', label: 'Payer' },
    { key: 'service', label: 'Service' }, { key: 'approved', label: 'Approved' },
    { key: 'used', label: 'Used' }, { key: 'expires', label: 'Expires' },
    { key: 'status', label: 'Status' },
];

export function AuthList() {
    return (
        <PageTemplate pageId="L7" title="📋 Service Authorizations" subtitle="Track approved hours, utilization & expiration dates"
            actionPageId="admin.authorizations"
            sectionData={PageSectionRegistry['L7']}
        />
    );
}

// --- Merged from R6-AuthUtilization.tsx ---
// PAGE IDENTITY: R6 · Auth Utilization | T49 · Auth Alerts

export function AuthUtilization() {
    return (
        <PageTemplate pageId="R6" title="📊 Authorization Utilization" subtitle="Payer-specific utilization rates, exhaustion forecasts & renewal tracking"
            sectionData={PageSectionRegistry['R6']}
        />
    );
}

// --- Merged from T49-AuthAlerts.tsx ---
// PAGE IDENTITY: T49 · Authorization Alerts

export function AuthAlerts() {
    return (
        <PageTemplate pageId="T49" title="🔔 Authorization Alerts" subtitle="Exhaustion warnings, expiration alerts & renewal notifications"
            sectionData={PageSectionRegistry['T49']}
        />
    );
}

// --- Extracted from automation.tsx ---
const cols_3: TableColumn[] = [
    { key: 'name', label: 'Automation' }, { key: 'trigger', label: 'Trigger' },
    { key: 'runs', label: 'Total Runs' }, { key: 'lastRun', label: 'Last Run' },
    { key: 'status', label: 'Status' },
];

export function AutoPilotDashboard() {
    return (
        <PageTemplate
            pageId="T7"
            title="🤖 AutoPilot Dashboard"
            subtitle="Workflow automations, event triggers, scheduled tasks & notification rules"
            actionPageId="admin.autopilot"
            sectionData={PageSectionRegistry['T7']}
        />
    );
}

// --- Extracted from booking-requests.tsx ---
const cols_4: TableColumn[] = [
    { key: 'id', label: 'Booking' }, { key: 'client', label: 'Client' },
    { key: 'service', label: 'Service' }, { key: 'requested', label: 'Requested' },
    { key: 'preferred', label: 'Preferred Time' }, { key: 'status', label: 'Status' },
];

export function BookingRequestQueue() {
    return (
        <PageTemplate pageId="L12" title="📅 Booking Request Queue" subtitle="Incoming service requests, assignment & scheduling"
            sectionData={PageSectionRegistry['L12']}
        />
    );
}

// --- Extracted from claims.tsx ---
// --- Merged from L10-ClaimsList.tsx ---
// PAGE IDENTITY: L10 · Claims List

export function ClaimsList() {
    return (
        <PageTemplate pageId="L10" title="📋 Claims Management" subtitle="Submit, track & manage insurance claims across all payers"
            actionPageId="admin.claims"
            sectionData={PageSectionRegistry['L10']}
        />
    );
}

// --- Merged from R12-ClaimsEra.tsx ---
// PAGE IDENTITY: R12 · Claims ERA

export function ClaimsEra() {
    return (
        <PageTemplate pageId="R12" title="💳 ERA Processing" subtitle="Electronic remittance advice reconciliation & posting"
            sectionData={PageSectionRegistry['R12']}
        />
    );
}

// --- Extracted from clinical-assistant.tsx ---
// Re-export from identity file: T8-ClinicalAssistant.tsx
// removed broken export: export { default } from './T8-ClinicalAssistant';


// --- Merged from T8-ClinicalAssistant.tsx ---
// ================================================================
// PAGE IDENTITY: T8 · Clinical Assistant
// Type: Tool | Owner: admin
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function ClinicalAssistant() {
    return (
        <PageTemplate
            pageId="T8"
            title="🩺 Clinical Assistant"
            subtitle="AI-powered clinical decision support, care planning & outcome tracking"
            actionPageId="admin.clinical-assistant"
            sectionData={PageSectionRegistry['T8']}
        />
    );
}

// --- Extracted from communications.tsx ---
const cols_5: TableColumn[] = [
    { key: 'to', label: 'Recipient' }, { key: 'template', label: 'Template' },
    { key: 'sent', label: 'Sent' }, { key: 'status', label: 'Status' },
    { key: 'cost', label: 'Cost' },
];

export function SMSHub() {
    return (
        <PageTemplate pageId="H22" title="📱 SMS & Notifications Hub" subtitle="Twilio-powered SMS delivery, templates & delivery analytics"
            sectionData={PageSectionRegistry['H22']}
        />
    );
}

// --- Extracted from consent.tsx ---
const cols_6: TableColumn[] = [
    { key: 'client', label: 'Client' }, { key: 'type', label: 'Consent Type' },
    { key: 'signed', label: 'Signed' }, { key: 'expires', label: 'Expires' },
    { key: 'status', label: 'Status' },
];

export function ConsentList() {
    return (
        <PageTemplate pageId="L8" title="📝 Consent Management" subtitle="Track signed consents, expirations & renewal requirements"
            sectionData={PageSectionRegistry['L8']}
        />
    );
}

// --- Merged from R7-ConsentExpiring.tsx ---
// PAGE IDENTITY: R7 · Consent Expiring Report

export function ConsentExpiring() {
    return (
        <PageTemplate pageId="R7" title="⏰ Consent Expiration Report" subtitle="Consents expiring within 30/60/90 days, renewal reminders"
            sectionData={PageSectionRegistry['R7']}
        />
    );
}

// --- Merged from T50-ConsentTemplates.tsx ---
// PAGE IDENTITY: T50 · Consent Templates

export function ConsentTemplates() {
    return (
        <PageTemplate pageId="T50" title="📄 Consent Templates" subtitle="Manage consent form templates, versions & digital signature workflows"
            sectionData={PageSectionRegistry['T50']}
        />
    );
}

// --- Extracted from content.tsx ---
// removed broken export: export { default } from './T2-ContentManager';


// --- Merged from T2-ContentManager.tsx ---
// ================================================================
// PAGE IDENTITY: T2 · Content Manager
// Type: Tool | Owner: admin
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function ContentManager() {
    const [tab, setTab] = useState('blogs');
    const tabs: TabItem[] = [
        { id: 'blogs', label: '📝 Blog Posts', count: 3 },
        { id: 'faqs', label: '❓ FAQs', count: 3 },
    ];

    return (
        <PageTemplate pageId="T2" title="📝 Content Manager" subtitle="Manage blog posts, FAQs & marketing content"
            actionPageId="admin.content-manager"
            sectionData={PageSectionRegistry['T2']}
        />
    );
}

// --- Extracted from cron.tsx ---
export function CronDashboard() {
    const { t } = useTranslation();

    return (
        <PageTemplate
            pageId="D6"
            title="⏱️ Scheduled Jobs Dashboard"
            subtitle="Monitor automated cron tasks — compliance sweeps, training reminders, auth monitoring & inventory alerts"
            actionPageId="admin.cron-dashboard"
            sectionData={PageSectionRegistry['D6']}
        />
    );
}

// --- Extracted from customers.tsx ---
// Re-export from identity file: L15-CustomerList.tsx
// removed broken export: export { default } from './L15-CustomerList';


// --- Merged from L15-CustomerList.tsx ---
// PAGE IDENTITY: L15 · Customer List
const cols_7: TableColumn[] = [
    { key: 'name', label: 'Client' }, { key: 'age', label: 'Age' },
    { key: 'service', label: 'Service' }, { key: 'visits', label: 'Frequency' },
    { key: 'status', label: 'Status' }, { key: 'since', label: 'Since' },
];

export function CustomerList() {
    return (
        <PageTemplate pageId="L15" title="👥 Client Directory" subtitle="All active clients, service details & care history"
            sectionData={PageSectionRegistry['L15']}
        />
    );
}

// --- Extracted from dashboard.tsx ---
// Barrel re-export — identity file: D1-AdminDashboard.tsx
// removed broken export: export { default } from './D1-AdminDashboard';


// --- Merged from D1-AdminDashboard.tsx ---
// ================================================================
// PAGE IDENTITY: D1 · Admin Dashboard (Main Landing)
// Type: Dashboard | Owner: admin | Registry: D1
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function AdminDashboard() {
    return (
        <PageTemplate pageId="D1" title="🏠 Admin Dashboard" subtitle="Platform overview — operations, finance, compliance & AI insights"
            actionPageId="admin.dashboard"
            sectionData={PageSectionRegistry['D1']}
        />
    );
}

// --- Merged from D2-RegistrySummary.tsx ---
// PAGE IDENTITY: D2 · Registry Summary

export function RegistrySummary() {
    return (
        <PageTemplate pageId="D2" title="📊 Registry Summary" subtitle="Overview of all platform registries — pages, APIs, sections, roles & events"
            sectionData={PageSectionRegistry['D2']}
        />
    );
}

// --- Extracted from documents.tsx ---
const cols_8: TableColumn[] = [
    { key: 'provider', label: 'Provider' }, { key: 'docType', label: 'Document Type' },
    { key: 'status', label: 'Status' }, { key: 'uploaded', label: 'Uploaded' },
    { key: 'expires', label: 'Expires' },
];

export function DocumentCenter() {
    return (
        <PageTemplate pageId="H6" title="📁 Document Management Center" subtitle="Upload, verify & manage PSW credentials, certifications & compliance documents"
            actionPageId="admin.documents"
            sectionData={PageSectionRegistry['H6']}
        />
    );
}

// --- Extracted from earnings.tsx ---
export const earningCols: TableColumn[] = [
    { key: 'service', label: 'Service' }, { key: 'hours', label: 'Hours' },
    { key: 'amount', label: 'Amount' }, { key: 'status', label: 'Status' },
    { key: 'date', label: 'Date' },
];

export function AdminEarningsPage() {
    return (
        <PageTemplate pageId="EARN" title="💰 Earnings & Revenue" subtitle="Invoices, payouts, revenue tracking & financial reporting"
            sectionData={PageSectionRegistry['EARN']}
        />
    );
}

// --- Extracted from erp.tsx ---
// --- Merged from H4-SupplyChainHub.tsx ---
// PAGE IDENTITY: H4 · Supply Chain / ERP Hub

export function SupplyChainHub() {
    return (
        <PageTemplate pageId="H4" title="📦 Supply Chain & ERP Hub" subtitle="Inventory, purchasing, vendor management & demand forecasting"
            sectionData={PageSectionRegistry['H4']}
        />
    );
}

// --- Extracted from evv.tsx ---
const cols_9: TableColumn[] = [
    { key: 'date', label: 'Date' }, { key: 'psw', label: 'PSW' },
    { key: 'client', label: 'Client' }, { key: 'type', label: 'Exception Type' },
    { key: 'detail', label: 'Detail' }, { key: 'status', label: 'Status' },
];

export function EvvExceptions() {
    return (
        <PageTemplate pageId="L22" title="⚠️ EVV Exceptions" subtitle="GPS mismatches, missing clock-ins & duration discrepancies"
            sectionData={PageSectionRegistry['L22']}
        />
    );
}

// --- Merged from R8-EvvExport.tsx ---
// PAGE IDENTITY: R8 · EVV Export

export function EvvExport() {
    return (
        <PageTemplate pageId="R8" title="📥 EVV Export" subtitle="Export EVV data for billing, compliance & payer submissions"
            sectionData={PageSectionRegistry['R8']}
        />
    );
}

// --- Extracted from form-registry.tsx ---
const FormRegistryPage: React.FC = () => {
    const [activeFormId, setActiveFormId] = useState<string | null>(null);
    const [searchTerm, setSearchTerm] = useState('');
    const [filterCategory, setFilterCategory] = useState<string>('all');

    const categories = useMemo(() => {
        const cats = new Set<string>();
        (FormRegistry as readonly FormEntry[]).forEach((f) => cats.add(f.category));
        return Array.from(cats);
    }, []);

    const filteredForms = useMemo(() => {
        return (FormRegistry as readonly FormEntry[]).filter(f => {
            const matchesSearch = f.label.toLowerCase().includes(searchTerm.toLowerCase()) ||
                                  f.id.toLowerCase().includes(searchTerm.toLowerCase()) ||
                                  f.apiEndpoint.toLowerCase().includes(searchTerm.toLowerCase());
            const matchesCategory = filterCategory === 'all' || f.category === filterCategory;
            return matchesSearch && matchesCategory;
        });
    }, [searchTerm, filterCategory]);

    const activeForm = useMemo(() =>
        (FormRegistry as readonly FormEntry[]).find(f => f.id === activeFormId) || null
    , [activeFormId]);

    const formsWithDeps = useMemo(() => (() => [])(), []);

    if (activeForm) {
                // @ts-ignore
        return <FormDetailView form={activeForm as FormEntry} onBack={() => setActiveFormId(null)} />;
    }

    // ── Registry Listing View ────────────────────────────────────────────
    return (
        <div role="main" aria-label="Form Registry" data-cy="form-registry-page" style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto' }}>
            {/* Header */}
            <div style={{ display: 'flex', alignItems: 'center', gap: '16px', marginBottom: '28px' }}>
                <div style={{
                    backgroundColor: 'var(--brand-50, #EFF6FF)',
                    padding: '14px', borderRadius: '12px',
                    border: '1px solid var(--brand-100, #DBEAFE)',
                }}>
                    <LayoutGrid size={28} color="var(--brand-500, #2563EB)" />
                </div>
                <div>
                    <h1 style={{ fontSize: '1.75rem', fontWeight: 800, margin: 0, color: 'var(--text-100, #0F172A)' }}>
                        Form Registry
                    </h1>
                    <p style={{ margin: '4px 0 0 0', color: 'var(--text-300, #94A3B8)', fontSize: '0.9rem' }}>
                        <div className="text-2xl font-bold">{Object.keys({}).length}</div> forms · {formsWithDeps.length} with inline creators · {categories.length} categories
                    </p>
                </div>
            </div>

            {/* Summary Cards */}
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gap: '16px', marginBottom: '24px' }}>
                <div className="pc-card" style={{ padding: '16px', textAlign: 'center' }}>
                    <div style={{ fontSize: '1.75rem', fontWeight: 800, color: 'var(--brand-500)' }}>{Object.keys(FormRegistry).length}</div>
                    <div style={{ fontSize: '0.75rem', fontWeight: 600, color: 'var(--text-300)', textTransform: 'uppercase' }}>Total Forms</div>
                </div>
                <div className="pc-card" style={{ padding: '16px', textAlign: 'center' }}>
                    <div style={{ fontSize: '1.75rem', fontWeight: 800, color: '#10B981' }}>{formsWithDeps.length}</div>
                    <div style={{ fontSize: '0.75rem', fontWeight: 600, color: 'var(--text-300)', textTransform: 'uppercase' }}>With Inline Creators</div>
                </div>
                <div className="pc-card" style={{ padding: '16px', textAlign: 'center' }}>
                    <div style={{ fontSize: '1.75rem', fontWeight: 800, color: '#8B5CF6' }}>{categories.length}</div>
                    <div style={{ fontSize: '0.75rem', fontWeight: 600, color: 'var(--text-300)', textTransform: 'uppercase' }}>Categories</div>
                </div>
                <div className="pc-card" style={{ padding: '16px', textAlign: 'center' }}>
                    <div style={{ fontSize: '1.75rem', fontWeight: 800, color: '#F59E0B' }}>
                        {(FormRegistry as readonly FormEntry[]).reduce((acc, f) => acc + f.fields.length, 0)}
                    </div>
                    <div style={{ fontSize: '0.75rem', fontWeight: 600, color: 'var(--text-300)', textTransform: 'uppercase' }}>Total Fields</div>
                </div>
            </div>

            {/* Search + Filter */}
            <div style={{ display: 'flex', gap: '12px', marginBottom: '24px' }}>
                <div style={{ flex: 1, position: 'relative' }}>
                    <Search size={16} color="#94A3B8" style={{ position: 'absolute', left: '12px', top: '11px' }} />
                    <input
                        data-cy="form-registry-search"
                        type="text"
                        placeholder="Search forms by name, ID, or endpoint..."
                        value={searchTerm}
                        onChange={e => setSearchTerm(e.target.value)}
                        style={{
                            width: '100%', boxSizing: 'border-box',
                            padding: '10px 14px 10px 36px', borderRadius: '8px',
                            border: '1px solid var(--border, #CBD5E1)',
                            fontSize: '0.85rem', outline: 'none',
                        }}
                    />
                </div>
                <div style={{ position: 'relative' }}>
                    <Filter size={14} color="#94A3B8" style={{ position: 'absolute', left: '10px', top: '12px' }} />
                    <select
                        data-cy="form-registry-filter"
                        value={filterCategory}
                        onChange={e => setFilterCategory(e.target.value)}
                        style={{
                            padding: '10px 14px 10px 30px', borderRadius: '8px',
                            border: '1px solid var(--border, #CBD5E1)',
                            fontSize: '0.85rem', outline: 'none', cursor: 'pointer',
                            appearance: 'auto', minWidth: '160px',
                        }}
                    >
                        <option value="all">All Categories</option>
                        {categories.map(cat => (
                            <option key={cat} value={cat}>
                                {CATEGORY_COLORS[cat]?.icon || '📄'} {cat.charAt(0).toUpperCase() + cat.slice(1)}
                            </option>
                        ))}
                    </select>
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(340px, 1fr))', gap: '16px' }}>
                {filteredForms.map(form => (
                // @ts-ignore
                    <FormCard key={form.id} form={form} onClick={() => setActiveFormId(form.id)} />
                ))}
            </div>

            {filteredForms.length === 0 && (
                <div style={{ textAlign: 'center', padding: '48px', color: 'var(--text-300)' }}>
                    <FileText size={48} color="var(--text-300)" style={{ marginBottom: '12px', opacity: 0.5 }} />
                    <p style={{ fontWeight: 600, margin: '0 0 6px 0' }}>No forms match your search</p>
                    <p style={{ fontSize: '0.85rem', margin: 0 }}>Try a different search term or category filter.</p>
                </div>
            )}
        </div>
    );
};

export default ((props: any) => <div/>);


// --- Merged from FormCard.tsx ---
export function FormCard() {
    return (
        <PageTemplate 
            pageId="PGE-FC" 
            title="✨ Form Card" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-FC']}
        />
    );
}

// --- Merged from FormDetailView.tsx ---
export function FormDetailView() {
    return (
        <PageTemplate 
            pageId="PGE-FDV" 
            title="✨ Form Detail View" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-FDV']}
        />
    );
}

// --- Extracted from formRegistryConfig.ts ---
export const CATEGORY_COLORS: Record<string, { bg: string; text: string; icon: string }> = {
    auth:          { bg: '#FEF3C7', text: '#92400E', icon: '🔐' },
    admin:         { bg: '#DBEAFE', text: '#1E40AF', icon: '⚙️' },
    'admin-wizard':{ bg: '#E0E7FF', text: '#3730A3', icon: '🧙' },
    client:        { bg: '#D1FAE5', text: '#065F46', icon: '👤' },
    psw:           { bg: '#FCE7F3', text: '#9D174D', icon: '🩺' },
    manager:       { bg: '#FEE2E2', text: '#991B1B', icon: '📊' },
    rn:            { bg: '#F0FDF4', text: '#166534', icon: '💉' },
    shared:        { bg: '#F1F5F9', text: '#334155', icon: '🔗' },
    marketing:     { bg: '#FDF4FF', text: '#86198F', icon: '📣' },
    platform:      { bg: '#EFF6FF', text: '#1D4ED8', icon: '🏢' },
    dam:           { bg: '#FAFAF9', text: '#44403C', icon: '🗄️' },
    coordinator:   { bg: '#ECFDF5', text: '#047857', icon: '📍' },
};

// --- Extracted from franchise.tsx ---
const locations = [
    { name: '📍 PrimeCare Toronto — Downtown', manager: 'Sarah Chen', psws: 24, clients: 67, revenue: '$142K', growth: '+12%', status: 'ACTIVE' },
    { name: '📍 PrimeCare Toronto — North York', manager: 'James Wilson', psws: 18, clients: 45, revenue: '$98K', growth: '+8%', status: 'ACTIVE' },
    { name: '📍 PrimeCare Mississauga', manager: 'Maria Santos', psws: 15, clients: 38, revenue: '$82K', growth: '+15%', status: 'ACTIVE' },
    { name: '📍 PrimeCare Ottawa', manager: 'Kevin O\'Brien', psws: 12, clients: 28, revenue: '$64K', growth: '+5%', status: 'ACTIVE' },
    { name: '📍 PrimeCare Vancouver', manager: 'Yuki Tanaka', psws: 8, clients: 15, revenue: '$32K', growth: '+22%', status: 'LAUNCHING' },
    { name: '📍 PrimeCare Calgary', manager: 'TBD', psws: 0, clients: 0, revenue: '—', growth: '—', status: 'PLANNED' },
];

const locationCols: TableColumn[] = [
    { key: 'name', label: 'Location' }, { key: 'manager', label: 'Manager' },
    { key: 'psws', label: 'PSWs' }, { key: 'clients', label: 'Clients' },
    { key: 'revenue', label: 'Revenue' }, { key: 'growth', label: 'Growth' },
    { key: 'status', label: 'Status' },
];

const expansion = [
    { name: '📍 Calgary, AB', description: 'Pop: 1.4M • Demand: High • Target: Q3 2026', progress: 65, badge: 'Q3 2026' },
    { name: '📍 Edmonton, AB', description: 'Pop: 1.0M • Demand: Medium • Target: Q4 2026', progress: 30, badge: 'Q4 2026' },
    { name: '📍 Winnipeg, MB', description: 'Pop: 750K • Demand: Medium • Target: Q1 2027', progress: 15, badge: 'Q1 2027' },
    { name: '📍 Montreal, QC', description: 'Pop: 1.8M • Demand: Very High • Target: Q2 2027', progress: 10, badge: 'Q2 2027' },
];

export function FranchiseManagement() {
    const [tab, setTab] = useState('locations');

    const tabContent: Record<string, Record<string, any>> = {
        locations: { 'H30.location-table': { table: { columns: locationCols, rows: locations } } },
        expansion: { 'H30.expansion': { progressList: { items: expansion } } },
    };

    return (
        <PageTemplate
            pageId="H30"
            title="🏢 Franchise Management"
            subtitle="Multi-location operations, performance benchmarking & expansion planning"
            actionPageId="admin.franchise"
            sectionData={PageSectionRegistry['H30']}
        />
    );
}

// --- Extracted from incidentHandlers.ts ---
export async function fetchIncidents(): Promise<any[]> {
    try { const res = await apiClient.get(ApiRegistry.ADMIN.INCIDENTS); if (res.ok) return await res.json(); } catch (e) { console.error('Failed to fetch incidents', e); }
    return [];
}

export async function resolveIncident(id: string, resolutionNotes: string): Promise<boolean> {
    try { const res = await apiClient.patch(`${ApiRegistry.ADMIN.INCIDENTS}/${id}`, { status: 'resolved', resolutionNotes }); return res.ok; } catch { return false; }
}

export async function deleteIncident(id: string): Promise<boolean> {
    try { const res = await apiClient.delete(`${ApiRegistry.ADMIN.INCIDENTS}/${id}`); return res.ok; } catch { return false; }
}

export function filterIncidents(incidents: any[], statusFilter: string, typeFilter: string): any[] {
    return incidents.filter(inc => {
        if (statusFilter !== 'all' && inc.status !== statusFilter) return false;
        if (typeFilter !== 'all' && inc.type?.toLowerCase() !== typeFilter) return false;
        return true;
    });
}

// --- Extracted from incidents.tsx ---
// removed re-export: export { IncidentList, IncidentEntry };


// --- Merged from F10-IncidentEntry.tsx ---
// PAGE IDENTITY: F10 · Incident Entry



export function IncidentEntry() {
    return (
        <PageTemplate pageId="F10" title="🚨 Incident Report" subtitle="Submit workplace incidents, near-misses & safety concerns"
            sectionData={PageSectionRegistry['F10']}
        />
    );
}

// --- Merged from IncidentEntry.tsx ---
export function IncidentEntryForm() {
    return (
        <PageTemplate 
            pageId="PGE-IEF" 
            title="✨ Incident Entry Form" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-IEF']}
        />
    );
}

// --- Merged from IncidentList.tsx ---
export function IncidentList_OLD1() {
    return (
        <PageTemplate 
            pageId="PGE-IL" 
            title="✨ Incident List" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-IL']}
        />
    );
}

// --- Merged from L2-IncidentList.tsx ---
// PAGE IDENTITY: L2 · Incident List
const cols_11: TableColumn[] = [
    { key: 'id', label: 'ID' }, { key: 'date', label: 'Date' },
    { key: 'type', label: 'Type' }, { key: 'client', label: 'Client' },
    { key: 'severity', label: 'Severity' }, { key: 'status', label: 'Status' },
];

export function IncidentList() {
    return (
        <PageTemplate pageId="L2" title="🚨 Incident List" subtitle="Track workplace incidents, near-misses, investigations & resolutions"
            sectionData={PageSectionRegistry['L2']}
        />
    );
}

// --- Extracted from insights.tsx ---
// Re-export from identity file: T9-AiInsights.tsx
// removed broken export: export { default } from './T9-AiInsights';


// --- Merged from T9-AiInsights.tsx ---
// PAGE IDENTITY: T9 · AI Insights



export function AiInsights() {
    return (
        <PageTemplate pageId="T9" title="🧠 AI Insights" subtitle="Machine learning model outputs, pattern detection & actionable recommendations"
            sectionData={PageSectionRegistry['T9']}
        />
    );
}

// --- Extracted from interoperability.tsx ---
// --- Merged from T5-FHIRCenter.tsx ---
// PAGE IDENTITY: T5 · FHIR Interoperability Center

export function FHIRCenter() {
    return (
        <PageTemplate pageId="T5" title="🔗 FHIR Interoperability Center" subtitle="HL7 FHIR resource management, API endpoints & data exchange"
            sectionData={PageSectionRegistry['T5']}
        />
    );
}

// --- Extracted from invoices.tsx ---
// removed re-export: export { InvoiceEntry };


// --- Merged from F9-InvoiceEntry.tsx ---
// PAGE IDENTITY: F9 · Invoice Entry



export function InvoiceEntry() {
    return (
        <PageTemplate pageId="F9" title="🧾 Invoice Entry" subtitle="Create and submit client invoices, service line items & payment terms"
            sectionData={PageSectionRegistry['F9']}
        />
    );
}

// --- Extracted from knowledge-base.tsx ---
// --- Merged from H8-KnowledgeBase.tsx ---
// PAGE IDENTITY: H8 · Knowledge Base

export function KnowledgeBase() {
    return (
        <PageTemplate pageId="H8" title="📚 Knowledge Base" subtitle="Internal wiki, SOPs, training resources & policy documentation"
            sectionData={PageSectionRegistry['H8']}
        />
    );
}

// --- Merged from T48-KBArticle.tsx ---
// PAGE IDENTITY: T48 · KB Article Editor

export function KBArticle() {
    return (
        <PageTemplate pageId="T48" title="✏️ KB Article Editor" subtitle="Create and edit knowledge base articles with rich text formatting"
            sectionData={PageSectionRegistry['T48']}
        />
    );
}

// --- Extracted from leads.tsx ---
// removed re-export: export { LeadsPage, LeadEntryForm, LeadConversion };


// --- Merged from F11-LeadEntry.tsx ---
// PAGE IDENTITY: F11 · Lead Entry



export function LeadEntryForm_OLD1() {
    return (
        <PageTemplate pageId="F11" title="➕ New Lead Entry" subtitle="Capture new lead information, service interest & contact details"
            sectionData={PageSectionRegistry['F11']}
        />
    );
}

// --- Merged from L3-LeadList.tsx ---
// PAGE IDENTITY: L3 · Lead List
const cols_12: TableColumn[] = [
    { key: 'name', label: 'Lead' }, { key: 'source', label: 'Source' },
    { key: 'service', label: 'Service' }, { key: 'stage', label: 'Stage' },
    { key: 'assigned', label: 'Assigned' }, { key: 'age', label: 'Age' },
];

export function LeadList() {
    return (
        <PageTemplate pageId="L3" title="🎯 Lead Pipeline" subtitle="Sales leads, conversion tracking & assignment management"
            sectionData={PageSectionRegistry['L3']}
        />
    );
}

// --- Merged from LeadEntry.tsx ---
export function LeadEntryForm() {
    return (
        <PageTemplate 
            pageId="PGE-LEF" 
            title="✨ Lead Entry Form" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-LEF']}
        />
    );
}

// --- Merged from T66-LeadConversion.tsx ---
// PAGE IDENTITY: T66 · Lead Conversion



export function LeadConversion() {
    return (
        <PageTemplate pageId="T66" title="🔄 Lead Conversion" subtitle="Convert qualified leads to active clients with automated onboarding"
            sectionData={PageSectionRegistry['T66']}
        />
    );
}

// --- Extracted from locations.tsx ---
const API_URL_13 = import.meta.env.VITE_API_URL;

export function LocationForm() {
    const { showToast } = useNotification();
    const navigate = useNavigate();
    const [isDirty, setIsDirty] = useState(false);
    const [showGuard, setShowGuard] = useState(false);
    const [submitting, setSubmitting] = useState(false);

    const [formData, setFormData] = useState({
        name: '',
        managerId: '',
        address: '',
        operatingHours: '08:00 - 20:00',
        capacity: 50,
        status: 'active'
    });

    useEffect(() => {
        const handleBeforeUnload = (e: BeforeUnloadEvent) => {
            if (isDirty) {
                e.preventDefault();
                e.returnValue = '';
            }
        };
        window.addEventListener('beforeunload', handleBeforeUnload);
        return () => window.removeEventListener('beforeunload', handleBeforeUnload);
    }, [isDirty]);

    const [managers, setManagers] = useState<any[]>([]);
    useEffect(() => {
        const fetchManagers = async () => {
            try {
                const token = localStorage.getItem('token');
                const res = await fetch(`${API_URL_13}/v1/admin/users`, {
                    headers: { 'Authorization': `Bearer ${token}` }
                });
                if (res.ok) {
                    const data = await res.json();
                    setManagers(Array.isArray(data) ? data.filter((u: any) => u.role === 'manager' || u.role === 'admin') : []);
                }
            } catch (e) { console.error(e); }
        };
        fetchManagers();
    }, []);

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setSubmitting(true);
        try {
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL_13}/v1/admin/locations`, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(formData)
            });

            if (response.ok) {
                showToast(ContentRegistry.LOCATIONS.MESSAGES.SUCCESS, 'success');
                setIsDirty(false);
                navigate(AdminRegistry.RouteRegistry.ADMIN.CUSTOMERS);
            } else {
                showToast(ContentRegistry.LOCATIONS.MESSAGES.ERROR, 'error');
            }
        } catch (error) {
            showToast(ContentRegistry.LOCATIONS.MESSAGES.ERROR_SUBMISSION, 'error');
        } finally {
            setSubmitting(false);
        }
    };

    return (
        <div style={{ maxWidth: '800px', margin: '0 auto', padding: '2rem' }} data-cy="form.location.page">
            {showGuard && (
                <div data-cy="guard.unsaved.dialog" style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.7)', zIndex: 10000, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <div style={{ background: 'white', padding: '32px', borderRadius: '16px', maxWidth: '400px', textAlign: 'center' }}>
                        <h2 data-cy="h2-admin.index-0" style={{ marginTop: 0 }}>{ContentRegistry.LOCATIONS.FORM.DISCARD_TITLE}</h2>
                        <p style={{ opacity: 0.8, marginBottom: '24px' }}>{ContentRegistry.LOCATIONS.FORM.DISCARD_DESC}</p>
                        <div style={{ display: 'flex', gap: '16px' }}>
                            <button data-cy="guard.unsaved.leave" onClick={() => navigate(-1)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}>Leave</button>
                            <button data-cy="guard.unsaved.stay" onClick={() => setShowGuard(false)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: 'none', background: '#004d40', color: 'white', cursor: 'pointer', fontWeight: 600 }}>Stay</button>
                        </div>
                    </div>
                </div>
            )}

            <div style={{ marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.75rem', fontWeight: 'bold' }} data-cy="page.title">{ContentRegistry.LOCATIONS.TITLE}</h2>
                <p style={{ color: '#6b7280' }} data-cy="page.subtitle">{ContentRegistry.LOCATIONS.SUBTITLE}</p>
            </div>

            <form data-cy="form-admin.index" onSubmit={handleSubmit} style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', border: '1px solid #e5e7eb' }}>
                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1.5rem' }}>
                    <div style={{ gridColumn: 'span 2' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>{ContentRegistry.LOCATIONS.FORM.NAME}</label>
                        <input
                            data-cy="form.location.name"
                            required
                            value={formData.name}
                            onChange={(e) => { setFormData({ ...formData, name: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        />
                    </div>

                    <div>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>{ContentRegistry.LOCATIONS.FORM.MANAGER}</label>
                        <select
                            data-cy="form.location.manager"
                            required
                            value={formData.managerId}
                            onChange={(e) => { setFormData({ ...formData, managerId: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        >
                            <option value="">{ContentRegistry.LOCATIONS.FORM.MANAGER_SELECT}</option>
                            {managers.map(m => (
                                <option key={m.id} value={m.id}>{m.fullName || m.email}</option>
                            ))}
                        </select>
                    </div>

                    <div>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>{ContentRegistry.LOCATIONS.FORM.CAPACITY}</label>
                        <input
                            data-cy="form.location.capacity"
                            type="number"
                            value={formData.capacity}
                            onChange={(e) => { setFormData({ ...formData, capacity: parseInt(e.target.value) }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        />
                    </div>

                    <div style={{ gridColumn: 'span 2' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>{ContentRegistry.LOCATIONS.FORM.ADDRESS}</label>
                        <input
                            data-cy="form.location.address"
                            required
                            value={formData.address}
                            onChange={(e) => { setFormData({ ...formData, address: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        />
                    </div>
                </div>

                <div style={{ marginTop: '2.5rem', display: 'flex', justifyContent: 'flex-end', gap: '1rem' }}>
                    <button
                        type="button"
                        onClick={() => isDirty ? setShowGuard(true) : navigate(-1)}
                        data-cy="btn-cancel"
                        style={{ padding: '0.75rem 2rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}
                    >
                        {ContentRegistry.LOCATIONS.FORM.CANCEL}
                    </button>
                    <button
                        type="submit"
                        disabled={submitting}
                        data-cy="form.location.save"
                        style={{ padding: '0.75rem 2rem', borderRadius: '0.5rem', border: 'none', background: '#004d40', color: 'white', fontWeight: 'bold', cursor: 'pointer' }}
                    >
                        {submitting ? ContentRegistry.LOCATIONS.FORM.SAVING : ContentRegistry.LOCATIONS.FORM.SAVE_BTN}
                    </button>
                </div>
            </form>
        </div>
    );
}

// --- Merged from F12-Locations.tsx ---
// PAGE IDENTITY: F12 · Locations



export function Locations() {
    return (
        <PageTemplate pageId="F12" title="📍 Service Locations" subtitle="Manage offices, service areas & geographic zones"
            sectionData={PageSectionRegistry['F12']}
        />
    );
}

// --- Merged from list.tsx ---
export function LocationsList() {
    return (
        <PageTemplate 
            pageId="PGE-LL" 
            title="✨ Locations List" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-LL']}
        />
    );
}

// --- Extracted from marketplace.tsx ---
export function Marketplace() {
    return (
        <PageTemplate 
            pageId="PG-276" 
            title="{ContentRegistry.MARKETPLACE.TITLE}" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-276']}
        />
    );
}

// --- Extracted from notifications.tsx ---
// --- Merged from H5-NotificationsHub.tsx ---
// PAGE IDENTITY: H5 · Notifications Hub

export function NotificationsHub() {
    return (
        <PageTemplate pageId="H5" title="🔔 Notifications Hub" subtitle="Push notifications, email alerts, SMS & in-app notification management"
            sectionData={PageSectionRegistry['H5']}
        />
    );
}

// --- Extracted from observability.tsx ---
export function ObservabilityDashboard() {
    return (
        <PageTemplate pageId="D6-OBS" title="📡 Observability Dashboard" subtitle="Application metrics, error tracking, latency & infrastructure health"
            isLive
            sectionData={PageSectionRegistry['D6-OBS']}
        />
    );
}

// --- Extracted from onboarding.tsx ---
// Barrel re-export — identity file: F7-StaffOnboarding.tsx
// removed broken export: export { default } from './F7-StaffOnboarding';


// --- Merged from F7-StaffOnboarding.tsx ---
// PAGE IDENTITY: F7 · Staff Onboarding



export function StaffOnboarding() {
    return (
        <PageTemplate pageId="F7" title="🎓 Staff Onboarding" subtitle="New hire onboarding workflow — credentials, training & compliance checklist"
            sectionData={PageSectionRegistry['F7']}
        />
    );
}

// --- Extracted from ops.tsx ---
// --- Merged from D7-OperationsCenter.tsx ---
// ================================================================
// PAGE IDENTITY: D7 · Operations Center  
// Type: Dashboard | Owner: admin | Registry: D7
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function OperationsCenter() {
    return (
        <PageTemplate
            pageId="D7"
            title="⚙️ Operations Center"
            subtitle="Real-time operational command — shifts, logistics, incidents & capacity"
            actionPageId="admin.operations"
            isLive
            sectionData={PageSectionRegistry['D7']}
        />
    );
}

// --- Merged from T67-SupplyDemand.tsx ---
// PAGE IDENTITY: T67 · Supply & Demand

export function SupplyDemand() {
    return (
        <PageTemplate pageId="T67" title="📊 Supply & Demand Analytics" subtitle="Staff capacity vs client demand — coverage gaps, forecasting & optimization"
            sectionData={PageSectionRegistry['T67']}
        />
    );
}

// --- Extracted from page-registry.tsx ---
type ViewMode = 'identity' | 'grid' | 'table';

export function PageRegistryPage() {
    const [searchTerm, setSearchTerm] = useState('');
    const [filterType, setFilterType] = useState<string>('all');
    const [filterOwner, setFilterOwner] = useState<string>('all');
    const [viewMode, setViewMode] = useState<ViewMode>('identity');
    const [selectedCode, setSelectedCode] = useState<string | null>(null);

    const masterEntries = useMemo(() => Object.entries({} as Record<string, MasterEntry>).map(([code, entry]) => ({ code, ...entry })), []);

    const filteredMaster = useMemo(() => masterEntries.filter(e => {
        const matchSearch = !searchTerm || e.code.toLowerCase().includes(searchTerm.toLowerCase()) || e.label.toLowerCase().includes(searchTerm.toLowerCase()) || e.file.toLowerCase().includes(searchTerm.toLowerCase()) || e.associates.some(a => a.toLowerCase().includes(searchTerm.toLowerCase()));
        return matchSearch && (filterType === 'all' || e.type === filterType) && (filterOwner === 'all' || e.owner === filterOwner);
    }), [masterEntries, searchTerm, filterType, filterOwner]);

    const groupedByOwner = useMemo(() => { const g: Record<string, typeof filteredMaster> = {}; filteredMaster.forEach(e => { (g[e.owner] = g[e.owner] || []).push(e); }); return g; }, [filteredMaster]);
    const masterTypeStats = useMemo(() => { const s: Record<string, number> = {}; masterEntries.forEach(e => { s[e.type] = (s[e.type] || 0) + 1; }); return s; }, [masterEntries]);
    const masterOwnerStats = useMemo(() => { const s: Record<string, number> = {}; masterEntries.forEach(e => { s[e.owner] = (s[e.owner] || 0) + 1; }); return s; }, [masterEntries]);

    const filteredPages = useMemo(() => (PageRegistry as PageEntry[]).filter(p => {
        const matchSearch = p.label.toLowerCase().includes(searchTerm.toLowerCase()) || p.id.toLowerCase().includes(searchTerm.toLowerCase()) || p.route.toLowerCase().includes(searchTerm.toLowerCase()) || p.categoryCode.toLowerCase().includes(searchTerm.toLowerCase()) || String(p.srNo).includes(searchTerm);
        return matchSearch && (filterType === 'all' || p.type === filterType) && (filterOwner === 'all' || p.owner === filterOwner);
    }), [searchTerm, filterType, filterOwner]);

    const grouped = useMemo(() => { const g: Record<string, PageEntry[]> = {}; filteredPages.forEach(p => { (g[p.type] = g[p.type] || []).push(p); }); return g; }, [filteredPages]);

    const selectedEntry = selectedCode ? {}?.[selectedCode] as MasterEntry | undefined : null;

    return (
        <div role="main" aria-label="Page Registry" data-cy="page-registry-page" style={{ padding: '24px', maxWidth: '1400px', margin: '0 auto' }}>
            {/* Header */}
            <div style={{ display: 'flex', alignItems: 'center', gap: '16px', marginBottom: '28px' }}>
                <div style={{ background: 'linear-gradient(135deg, #1E40AF 0%, #7C3AED 100%)', padding: '14px', borderRadius: '14px', boxShadow: '0 4px 12px rgba(124,58,237,0.3)' }}><Network size={28} color="white" /></div>
                <div style={{ flex: 1 }}>
                    <h1 style={{ fontSize: '1.75rem', fontWeight: 800, margin: 0, color: '#0F172A' }}>Identity Registry Dashboard</h1>
                    <p style={{ margin: '4px 0 0 0', color: '#94A3B8', fontSize: '0.9rem' }}>{Object.keys({} || {}).length || masterEntries.length} identity codes · {Object.keys(masterOwnerStats).length} owners · {Object.keys(masterTypeStats).length} types · Every page mapped with associates</p>
                </div>
                <div style={{ display: 'flex', gap: '4px', background: '#F1F5F9', borderRadius: '8px', padding: '3px' }}>
                    {[{ key: 'identity' as ViewMode, label: 'Identity Map', icon: <Network size={13} /> }, { key: 'grid' as ViewMode, label: 'Grid', icon: <LayoutGrid size={13} /> }, { key: 'table' as ViewMode, label: 'Table', icon: <List size={13} /> }].map(v => (
                        <button key={v.key} data-cy={`view-mode-${v.key}`} onClick={() => setViewMode(v.key)}
                            style={{ display: 'flex', alignItems: 'center', gap: '4px', padding: '6px 12px', borderRadius: '6px', border: 'none', cursor: 'pointer', background: viewMode === v.key ? 'white' : 'transparent', fontWeight: viewMode === v.key ? 700 : 500, fontSize: '0.78rem', boxShadow: viewMode === v.key ? '0 1px 3px rgba(0,0,0,0.1)' : 'none', color: viewMode === v.key ? '#1E40AF' : '#64748B' }}>
                            {v.icon} {v.label}
                        </button>
                    ))}
                </div>
            </div>

            {/* KPI Strip */}
            <div data-cy="identity-kpi-strip" style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(120px, 1fr))', gap: '10px', marginBottom: '20px' }}>
                {Object.entries(masterTypeStats).sort((a, b) => b[1] - a[1]).map(([type, count]) => {
                    const meta = TYPE_META[type as PageType]; if (!meta) return null;
                    const isActive = filterType === type;
                    return (<button key={type} data-cy={`kpi-${type}`} onClick={() => setFilterType(isActive ? 'all' : type)}
                        style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', padding: '12px 8px', borderRadius: '12px', border: isActive ? `2px solid ${meta.color}` : '1px solid #E2E8F0', background: isActive ? meta.bg : 'white', cursor: 'pointer', transition: 'all 0.15s' }}>
                        <span style={{ color: meta.color, marginBottom: '4px' }}>{meta.icon}</span>
                        <span style={{ fontWeight: 900, fontSize: '1.4rem', color: meta.color, lineHeight: 1 }}>{count}</span>
                        <span style={{ fontWeight: 700, fontSize: '0.6rem', color: isActive ? meta.color : '#94A3B8', textTransform: 'uppercase', marginTop: '2px' }}>{meta.label}s</span>
                    </button>);
                })}
            </div>

            {/* Search + Owner Filter */}
            <div style={{ display: 'flex', gap: '12px', marginBottom: '24px' }}>
                <div style={{ flex: 1, position: 'relative' }}>
                    <Search size={16} color="#94A3B8" style={{ position: 'absolute', left: '12px', top: '11px' }} />
                    <input data-cy="page-registry-search" type="text" placeholder="Search by code (D4), label, file path, or associate..." value={searchTerm} onChange={e => setSearchTerm(e.target.value)}
                        style={{ width: '100%', boxSizing: 'border-box', padding: '10px 14px 10px 36px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '0.85rem', outline: 'none' }} />
                </div>
                <div style={{ position: 'relative' }}>
                    <Filter size={14} color="#94A3B8" style={{ position: 'absolute', left: '10px', top: '12px' }} />
                    <select data-cy="page-registry-owner-filter" value={filterOwner} onChange={e => setFilterOwner(e.target.value)}
                        style={{ padding: '10px 14px 10px 30px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '0.85rem', outline: 'none', cursor: 'pointer', minWidth: '160px' }}>
                        <option value="all">All Owners</option>
                        {Object.entries(masterOwnerStats).sort((a, b) => b[1] - a[1]).map(([owner, count]) => (
                            <option key={owner} value={owner}>{OWNER_META[owner]?.icon || '📄'} {owner} ({count})</option>
                        ))}
                    </select>
                </div>
            </div>

            {viewMode === 'identity' && (
                // @ts-ignore
                <IdentityMapView groupedByOwner={groupedByOwner} selectedCode={selectedCode} setSelectedCode={setSelectedCode} selectedEntry={selectedEntry || null} />
            )}
            {viewMode === 'table' && (
                // @ts-ignore
                <TableView filteredMaster={filteredMaster} />
            )}
            {viewMode === 'grid' && (
                // @ts-ignore
                <GridView grouped={grouped} />
            )}

            {filteredMaster.length === 0 && viewMode === 'identity' && (
                <div style={{ textAlign: 'center', padding: '48px', color: '#94A3B8' }}>
                    <Network size={48} style={{ marginBottom: '12px', opacity: 0.5 }} />
                    <p style={{ fontWeight: 600, margin: '0 0 6px' }}>No pages match your filters</p>
                    <p style={{ fontSize: '0.85rem', margin: 0 }}>Try adjusting search, type, or owner filters.</p>
                </div>
            )}
        </div>
    );
}


// --- Merged from GridView.tsx ---
export function GridView() {
    return (
        <PageTemplate 
            pageId="PGE-GV" 
            title="✨ Grid View" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-GV']}
        />
    );
}

// --- Merged from IdentityMapView.tsx ---
export function IdentityMapView() {
    return (
        <PageTemplate 
            pageId="PGE-IMV" 
            title="✨ Identity Map View" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-IMV']}
        />
    );
}

// --- Merged from TableView.tsx ---
export function TableView() {
    return (
        <PageTemplate 
            pageId="PGE-TV" 
            title="✨ Table View" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-TV']}
        />
    );
}
// --- Merged sidecars ---

/* Merged from registryMeta.tsx */




export const TYPE_META: Record<PageType, { color: string; bg: string; icon: React.ReactNode; label: string }> = {
    dashboard:  { color: '#1D4ED8', bg: '#DBEAFE', icon: <BarChart3 size={14} />, label: 'Dashboard' },
    form:       { color: '#065F46', bg: '#D1FAE5', icon: <ClipboardList size={14} />, label: 'Form' },
    list:       { color: '#92400E', bg: '#FEF3C7', icon: <Layers size={14} />, label: 'List' },
    hub:        { color: '#9D174D', bg: '#FCE7F3', icon: <Compass size={14} />, label: 'Hub' },
    wizard:     { color: '#5B21B6', bg: '#EDE9FE', icon: <Wand2 size={14} />, label: 'Wizard' },
    report:     { color: '#166534', bg: '#DCFCE7', icon: <FileText size={14} />, label: 'Report' },
    tool:       { color: '#0369A1', bg: '#E0F2FE', icon: <Wrench size={14} />, label: 'Tool' },
    portal:     { color: '#B45309', bg: '#FEF9C3', icon: <Globe size={14} />, label: 'Portal' },
    registry:   { color: '#7C3AED', bg: '#F3E8FF', icon: <BookOpen size={14} />, label: 'Registry' },
    settings:   { color: '#374151', bg: '#F3F4F6', icon: <Wrench size={14} />, label: 'Settings' },
    detail:     { color: '#4338CA', bg: '#E0E7FF', icon: <FileText size={14} />, label: 'Detail' },
    error:      { color: '#DC2626', bg: '#FEE2E2', icon: <AlertTriangle size={14} />, label: 'Error' },
};

export const OWNER_META: Record<string, { icon: string; color: string; bg: string }> = {
    admin:         { icon: '⚙️', color: '#1E40AF', bg: '#DBEAFE' },
    superuser:     { icon: '👑', color: '#92400E', bg: '#FEF3C7' },
    manager:       { icon: '📊', color: '#7C3AED', bg: '#EDE9FE' },
    staff:         { icon: '👥', color: '#0369A1', bg: '#E0F2FE' },
    psw:           { icon: '🩺', color: '#065F46', bg: '#D1FAE5' },
    rn:            { icon: '💉', color: '#DC2626', bg: '#FEE2E2' },
    client:        { icon: '👤', color: '#B45309', bg: '#FEF9C3' },
    coordinator:   { icon: '📍', color: '#9D174D', bg: '#FCE7F3' },
    allied:        { icon: '🏥', color: '#166534', bg: '#DCFCE7' },
    'scrum-master':{ icon: '🔧', color: '#374151', bg: '#F3F4F6' },
    auth:          { icon: '🔐', color: '#4338CA', bg: '#E0E7FF' },
    shared:        { icon: '🔗', color: '#64748B', bg: '#F1F5F9' },
};

// --- Extracted from pages.tsx ---
// --- Merged from test.tsx ---
export function TestPage() {
    return (
        <PageTemplate 
            pageId="PGE-TP" 
            title="✨ Test Page" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-TP']}
        />
    );
}

// --- Extracted from payroll.tsx ---
export function PayrollHub() {
    return (
        <PageTemplate
            pageId="H7"
            title="💵 Payroll Hub"
            subtitle="Payroll processing, deductions, tax withholding & direct deposit management"
            actionPageId="admin.payroll"
            sectionData={PageSectionRegistry['H7']}
        />
    );
}

// --- Extracted from pharmacy.tsx ---
export function PharmacyHub() {
    return (
        <PageTemplate
            pageId="H2"
            title="💊 Pharmacy & Medication Hub"
            subtitle="E-prescribing, MAR tracking, ADC integration, and BCMA"
            actionPageId="admin.pharmacy"
            sectionData={PageSectionRegistry['H2']}
        />
    );
}

// --- Extracted from rcm.tsx ---
// --- Merged from H3-RevenueCycleHub.tsx ---
// ================================================================
// PAGE IDENTITY: H3 · Revenue Cycle Hub
// Type: Hub | Owner: admin | Registry: H3
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function RevenueCycleHub() {
    return (
        <PageTemplate
            pageId="H3"
            title="💰 Revenue Cycle Hub"
            subtitle="End-to-end revenue cycle management — claims, billing, ERA & collections"
            actionPageId="admin.revenue-cycle"
            sectionData={PageSectionRegistry['H3']}
        />
    );
}

// --- Extracted from reference-data.tsx ---
// --- Merged from H9-ReferenceDataHub.tsx ---
// ================================================================
// PAGE IDENTITY: H9 · Reference Data Hub
// Type: Hub | Owner: admin | Registry: H9
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function ReferenceDataHub() {
    return (
        <PageTemplate
            pageId="H9"
            title="🗂️ Reference Data Hub"
            subtitle="Master data management — service codes, diagnosis codes, facilities & fee schedules"
            actionPageId="admin.reference-data"
            sectionData={PageSectionRegistry['H9']}
        />
    );
}

// --- Extracted from referrals.tsx ---
const cols_14: TableColumn[] = [
    { key: 'id', label: 'Ref ID' }, { key: 'source', label: 'Source' },
    { key: 'client', label: 'Client' }, { key: 'service', label: 'Service' },
    { key: 'received', label: 'Received' }, { key: 'status', label: 'Status' },
];

export function ReferralList() {
    return (
        <PageTemplate pageId="L9" title="🔗 Referral Pipeline" subtitle="Incoming referrals, intake tracking & source analytics"
            sectionData={PageSectionRegistry['L9']}
        />
    );
}

// --- Merged from R11-ReferralAnalytics.tsx ---
// PAGE IDENTITY: R11 · Referral Analytics

export function ReferralAnalytics() {
    return (
        <PageTemplate pageId="R11" title="📊 Referral Analytics" subtitle="Referral source analysis, conversion rates & pipeline metrics"
            sectionData={PageSectionRegistry['R11']}
        />
    );
}

// --- Extracted from reports.tsx ---
// Re-export from identity file: R1-ReportCenter.tsx
// removed broken export: export { default } from './R1-ReportCenter';


// --- Merged from R1-ReportCenter.tsx ---
// PAGE IDENTITY: R1 · Report Center

export function ReportCenter() {
    return (
        <PageTemplate pageId="R1" title="📊 Report Center" subtitle="Comprehensive reporting suite — financial, clinical, HR, compliance & custom"
            sectionData={PageSectionRegistry['R1']}
        />
    );
}

// --- Merged from R2-ExportPage.tsx ---
// PAGE IDENTITY: R2 · Export Page



export function ExportPage() {
    return (
        <PageTemplate pageId="R2" title="📥 Data Export" subtitle="Export platform data in CSV, PDF, Excel & JSON formats"
            sectionData={PageSectionRegistry['R2']}
        />
    );
}

// --- Extracted from reseller.tsx ---
// --- Merged from PrivateMarketplace.tsx ---
export function PrivateMarketplace() {
    return (
        <PageTemplate 
            pageId="PG-131" 
            title="Private Marketplace" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-131']}
        />
    );
}

// --- Merged from ResellerDashboard.tsx ---
export function ResellerDashboard() {
    return (
        <PageTemplate 
            pageId="PG-390" 
            title="White-Label Reseller Hub" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-390']}
        />
    );
}

// --- Merged sidecars ---

/* Merged from resellerHandlers.ts */
// ResellerDashboard: fetch/provision handlers extracted
const API_URL_15 = import.meta.env.VITE_API_URL || 'http://localhost:4000';

export const FALLBACK_CHILDREN = [
    { id: 't1', name: 'West Coast HomeCare', slug: 'west-coast', usersCount: 24, status: 'active', revenue: '$12,400' },
    { id: 't2', name: 'Ontario Senior Support', slug: 'ontario-senior', usersCount: 12, status: 'pending', revenue: '$0' },
];

export async function fetchChildAgencies(): Promise<any[]> {
    try {
        const token = localStorage.getItem('token');
        const res = await fetch(`${API_URL_13}${ApiRegistry.ADMIN.RESELLER.DASHBOARD}`, { headers: { 'Authorization': `Bearer ${token}` } });
        if (res.ok) { const data = await res.json(); return data.children || FALLBACK_CHILDREN; }
        return FALLBACK_CHILDREN;
    } catch { return FALLBACK_CHILDREN; }
}

export async function provisionAgency(tenant: { name: string; slug: string; adminEmail: string; adminPassword: string }): Promise<void> {
    const token = localStorage.getItem('token');
    const res = await fetch(`${API_URL_13}${ApiRegistry.ADMIN.RESELLER.PROVISION}`, { method: 'POST', headers: { 'Content-Type': 'application/json', 'Authorization': `Bearer ${token}` }, body: JSON.stringify(tenant) });
    if (!res.ok) { const err = await res.json(); throw new Error(err.error || 'Failed to provision'); }
}

// --- Extracted from role-editor.tsx ---
// Re-export from identity file: T4-RoleEditor.tsx
// removed broken export: export { default } from './T4-RoleEditor';


// --- Merged from list.tsx ---
export function RolesList() {
    return (
        <PageTemplate 
            pageId="PGE-RL" 
            title="✨ Roles List" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-RL']}
        />
    );
}

// --- Merged from T4-RoleEditor.tsx ---
// PAGE IDENTITY: T4 · Role Editor
const cols_16: TableColumn[] = [
    { key: 'name', label: 'Role' }, { key: 'users', label: 'Users' },
    { key: 'permissions', label: 'Permissions' }, { key: 'scope', label: 'Scope' },
    { key: 'status', label: 'Status' },
];

export function RoleEditor() {
    return (
        <PageTemplate pageId="T4" title="🔑 Role Editor" subtitle="Define roles, assign permissions & manage access hierarchies"
            sectionData={PageSectionRegistry['T4']}
        />
    );
}

// --- Extracted from schedule.tsx ---
// Re-export from identity file: L1-Schedule.tsx
// removed broken export: export { default } from './L1-Schedule';


// --- Merged from L1-Schedule.tsx ---
// PAGE IDENTITY: L1 · Schedule



export function Schedule() {
    return (
        <PageTemplate pageId="L1" title="📅 Schedule Management" subtitle="Shift scheduling, coverage tracking & calendar overview"
            sectionData={PageSectionRegistry['L1']}
        />
    );
}

// --- Extracted from search.tsx ---
// --- Merged from T1-SearchPage.tsx ---
// PAGE IDENTITY: T1 · Search Page

export function SearchPage() {
    return (
        <PageTemplate pageId="T1" title="🔍 Global Search" subtitle="Search across clients, PSWs, visits, documents, invoices & more"
            sectionData={PageSectionRegistry['T1']}
        />
    );
}

// --- Extracted from security.tsx ---
// --- Merged from D3-AccountingDashboard.tsx ---
// ================================================================
// PAGE IDENTITY: D3 · Accounting Dashboard
// Type: Dashboard | Owner: admin | Registry: D3
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function AccountingDashboard() {
    return (
        <PageTemplate
            pageId="D3"
            title="📒 Accounting Dashboard"
            subtitle="Double-entry ledger, P&L, balance sheet & cash flow overview"
            actionPageId="admin.accounting"
            sectionData={PageSectionRegistry['D3']}
        />
    );
}

// --- Merged from L16-AuditTrailViewer.tsx ---
// ================================================================
// PAGE IDENTITY: L16 · Audit Trail Viewer
// Type: List | Owner: admin | Registry: L24
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function AuditTrailViewer() {
    return (
        <PageTemplate
            pageId="L24"
            title="🔍 Audit Trail"
            subtitle="Complete system activity log — who did what, when, and from where"
            actionPageId="admin.audit-trail"
            sectionData={PageSectionRegistry['L24']}
        />
    );
}

// --- Merged from SecurityDashboard.tsx ---
export function SecurityDashboard() {
    return (
        <PageTemplate 
            pageId="PGE-SD" 
            title="✨ Security Dashboard" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-SD']}
        />
    );
}

// --- Merged from T10-SecurityGovernance.tsx ---
// ================================================================
// PAGE IDENTITY: T10 · Security Governance
// Type: Tool | Owner: admin | Registry: T10
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function SecurityGovernance() {
    return (
        <PageTemplate
            pageId="T10"
            title="🛡️ Security Governance"
            subtitle="Threat monitoring, compliance, access reviews & incident response"
            actionPageId="admin.security-governance"
            sectionData={PageSectionRegistry['T10']}
        />
    );
}

// --- Merged from T13-DeviceManagement.tsx ---
// PAGE IDENTITY: T13 · Device Management

export function DeviceManagement() {
    return (
        <PageTemplate pageId="T13" title="📱 Device Management" subtitle="Registered devices, trust levels, remote wipe & session management"
            sectionData={PageSectionRegistry['T13']}
        />
    );
}

// --- Merged from T14-ForensicTrails.tsx ---
// ================================================================
// PAGE IDENTITY: T14 · Forensic Trails
// Type: Tool | Owner: admin | Registry: T14
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function ForensicTrails() {
    return (
        <PageTemplate
            pageId="T14"
            title="🔬 Forensic Trails"
            subtitle="Immutable audit log with full chain-of-custody for compliance & investigations"
            actionPageId="admin.forensic-trails"
            sectionData={PageSectionRegistry['T14']}
        />
    );
}

// --- Merged from T15-CorsSettings.tsx ---
// ================================================================
// PAGE IDENTITY: T15 · CORS Settings
// Type: Tool | Owner: admin | Registry: T15
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function CorsSettings() {
    return (
        <PageTemplate
            pageId="T15"
            title="🌐 CORS Settings"
            subtitle="Cross-Origin Resource Sharing configuration and allowed origins management"
            actionPageId="admin.cors-settings"
            sectionData={PageSectionRegistry['T15']}
        />
    );
}

// --- Merged from T16-IntegrityVerification.tsx ---
// PAGE IDENTITY: T16 · Integrity Verification

export function IntegrityVerification() {
    return (
        <PageTemplate pageId="T16" title="🔒 Integrity Verification" subtitle="Data integrity checks, checksum validation & tamper detection"
            sectionData={PageSectionRegistry['T16']}
        />
    );
}

// --- Merged from T17-FinancialLedger.tsx ---
// ================================================================
// PAGE IDENTITY: T17 · Financial Ledger
// Type: Tool | Owner: admin | Registry: T17
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function FinancialLedger() {
    return (
        <PageTemplate
            pageId="T17"
            title="📒 Financial Ledger"
            subtitle="Double-entry journal, general ledger, trial balance & reconciliation"
            actionPageId="admin.financial-ledger"
            sectionData={PageSectionRegistry['T17']}
        />
    );
}

// --- Merged from T18-TaxComplianceHub.tsx ---
// ================================================================
// PAGE IDENTITY: T18 · Tax Compliance Hub
// Type: Tool | Owner: admin | Registry: T18
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function TaxComplianceHub() {
    return (
        <PageTemplate
            pageId="T18"
            title="🏛️ Tax Compliance Hub"
            subtitle="HST/GST filing, WSIB, T4 generation, EHT & CRA audit trail"
            actionPageId="admin.tax-compliance"
            sectionData={PageSectionRegistry['T18']}
        />
    );
}

// --- Merged from T56-PermissionGrid.tsx ---
// ================================================================
// PAGE IDENTITY: T56 · Permission Grid
// Type: Tool | Owner: admin | Registry: T56
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function PermissionGrid() {
    return (
        <PageTemplate
            pageId="T56"
            title="🔒 Permission Grid"
            subtitle="Role-based access control matrix, permission audits & conflict detection"
            actionPageId="admin.permission-grid"
            sectionData={PageSectionRegistry['T56']}
        />
    );
}

// --- Merged from T57-SessionMonitor.tsx ---
// ================================================================
// PAGE IDENTITY: T57 · Session Monitor
// Type: Tool | Owner: admin | Registry: T57
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function SessionMonitor() {
    return (
        <PageTemplate
            pageId="T57"
            title="📡 Session Monitor"
            subtitle="Real-time active sessions, suspicious activity detection & session management"
            actionPageId="admin.session-monitor"
            isLive
            sectionData={PageSectionRegistry['T57']}
        />
    );
}

// --- Merged from T58-ThreatDetection.tsx ---
// ================================================================
// PAGE IDENTITY: T58 · Threat Detection
// Type: Tool | Owner: admin | Registry: T58
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function ThreatDetection() {
    return (
        <PageTemplate
            pageId="T58"
            title="🚨 Threat Detection"
            subtitle="Real-time threat monitoring, intrusion detection & automated response"
            actionPageId="admin.threat-detection"
            isLive
            sectionData={PageSectionRegistry['T58']}
        />
    );
}

// --- Merged sidecars ---

/* Merged from deviceHandlers.ts */
// T13 Device Management: interfaces and API handlers extracted


export interface Device {
    id: string; userId: string; deviceId: string; deviceName: string | null;
    deviceType: string | null; lastIp: string | null; status: string;
    isAuthorized: boolean; isTemporary: boolean; expiresAt: string | null;
    lastActiveAt: string; user: { firstName: string | null; lastName: string | null; email: string; };
}

export interface AuditLog { id: string; action: string; resourceType: string; createdAt: string; ipAddress: string | null; metadataJson: any; }

export async function fetchDevices(): Promise<Device[]> {
    try { const res = await apiClient.get('/v1/admin/settings/security/devices'); if (res.ok) return await res.json(); } catch (e) { console.error('Failed to fetch devices:', e); }
    return [];
}

export async function authorizeDevice(id: string): Promise<boolean> {
    try { const res = await apiClient.post(`/v1/admin/settings/security/devices/${id}/authorize`); return res.ok; } catch { return false; }
}

export async function revokeDevice(id: string): Promise<boolean> {
    try { const res = await apiClient.post(`/v1/admin/settings/security/devices/${id}/revoke`); return res.ok; } catch { return false; }
}

export async function fetchDeviceActivity(deviceId: string): Promise<AuditLog[]> {
    try { const res = await apiClient.get(`/v1/admin/settings/security/devices/${deviceId}/activity`); if (res.ok) return await res.json(); } catch (e) { console.error('Failed to fetch activity:', e); }
    return [];
}


/* Merged from useAccountingData.ts */
// D3 — Accounting Dashboard: TypeScript interfaces and data loading hook

export interface TradingAccount {
    revenue: number;
    directCosts: number;
    grossProfit: number;
    grossProfitMargin: number;
    breakdown: { revenue: Record<string, number>; directCosts: Record<string, number> };
}

export interface ProfitAndLoss {
    operatingExpenses: number;
    netIncome: number;
    breakdown: { indirectExpenses: Record<string, number> };
}

export interface BalanceSheet {
    date: string;
    assets: { total: number; accounts: Record<string, number> };
    liabilities: { total: number; accounts: Record<string, number> };
    equity: { total: number; accounts: Record<string, number> };
}

export interface ForecastPoint { date: string; projectedCash: number; }

export interface ForecastingResult {
    currentCash: number;
    avgDailyRevenue: number;
    avgDailyBurn: number;
    netDailyFlow: number;
    daysOfRunway: number | 'infinite';
    forecast: ForecastPoint[];
}

const ACCOUNTING_QK = ['platform', 'admin', 'reporting'];

export function useAccountingData(showToast: (msg: string, type: any) => void) {
    const queryClient = useQueryClient();

    // 5 parallel useRegistryQuery hooks (React Query fetches independently & in parallel)
    const { data: tradingAcc = null, isLoading: taLoading } = useRegistryQuery<TradingAccount>(
        ApiRegistry.PLATFORM.ADMIN.REPORTING.TRADING_ACCOUNT,
        { queryKey: [...ACCOUNTING_QK, 'trading-account'], staleTime: 60_000 }
    );

    const { data: pAndL = null, isLoading: plLoading } = useRegistryQuery<ProfitAndLoss>(
        ApiRegistry.PLATFORM.ADMIN.REPORTING.PROFIT_LOSS,
        { queryKey: [...ACCOUNTING_QK, 'profit-loss'], staleTime: 60_000 }
    );

    const { data: balanceSheet = null, isLoading: bsLoading } = useRegistryQuery<BalanceSheet>(
        ApiRegistry.PLATFORM.ADMIN.REPORTING.BALANCE_SHEET,
        { queryKey: [...ACCOUNTING_QK, 'balance-sheet'], staleTime: 60_000 }
    );

    const { data: reconSummary = null, isLoading: reconLoading } = useRegistryQuery<{ unreconciledBankCount: number; unreconciledLedgerCount: number }>(
        ApiRegistry.PLATFORM.ADMIN.REPORTING.RECONCILIATION_SUMMARY,
        { queryKey: [...ACCOUNTING_QK, 'reconciliation-summary'], staleTime: 30_000 }
    );

    const { data: forecastData = null, isLoading: fcLoading } = useRegistryQuery<ForecastingResult>(
        ApiRegistry.PLATFORM.ADMIN.REPORTING.FORECAST,
        { queryKey: [...ACCOUNTING_QK, 'forecast'], staleTime: 60_000 }
    );

    const loading = taLoading || plLoading || bsLoading || reconLoading || fcLoading;

    const loadData = () => {
        queryClient.invalidateQueries({ queryKey: ACCOUNTING_QK });
    };

    const handleAutoReconcile = async () => {
        try {
            const res = await apiClient.post(ApiRegistry.PLATFORM.ADMIN.REPORTING.AUTO_RECONCILE, {});
            if (res.ok) {
                const data = await res.json();
                showToast(`Successfully matched ${data.matchedCount} transactions!`, 'success');
                loadData();
            }
        } catch (error) {
            showToast('Auto-reconciliation failed', 'error');
            console.error('Auto-reconciliation failed:', error);
        }
    };

    return { tradingAcc, pAndL, balanceSheet, reconSummary, forecastData, loading, loadData, handleAutoReconcile };
}


/* Merged from useLedgerData.ts */
// T17 Financial Ledger: interfaces and data loading hook




export interface JournalEntry {
    id: string;
    account: { code: string; name: string };
    debit: number;
    credit: number;
    balanceBefore: number;
    balanceAfter: number;
}

export interface FinancialTransaction {
    id: string;
    type: string;
    referenceId: string;
    amount: number;
    status: string;
    createdAt: string;
    journalEntries: JournalEntry[];
}

export interface AccountBalance {
    code: string;
    name: string;
    type: string;
    balance: number;
}

const LEDGER_QK = ['platform', 'admin', 'financial'];

export function useLedgerData_2(showToast: (msg: string, type: any) => void) {
    const queryClient = useQueryClient();

    // 4 parallel useRegistryQuery hooks (React Query fetches them independently & in parallel)
    const { data: transactions = [], isLoading: txLoading } = useRegistryQuery<FinancialTransaction[]>(
        '/platform/admin/financial',
        { queryKey: [...LEDGER_QK, 'transactions'], staleTime: 30_000 }
    );

    const { data: balances = [], isLoading: balLoading } = useRegistryQuery<AccountBalance[]>(
        '/platform/admin/financial/balances',
        { queryKey: [...LEDGER_QK, 'balances'], staleTime: 30_000 }
    );

    const { data: pAndL = null, isLoading: plLoading } = useRegistryQuery<any>(
        '/platform/admin/financial/reports/p-and-l',
        { queryKey: [...LEDGER_QK, 'p-and-l'], staleTime: 60_000 }
    );

    const { data: balanceSheet = null, isLoading: bsLoading } = useRegistryQuery<any>(
        '/platform/admin/financial/reports/balance-sheet',
        { queryKey: [...LEDGER_QK, 'balance-sheet'], staleTime: 60_000 }
    );

    const loading = txLoading || balLoading || plLoading || bsLoading;

    const loadData = () => {
        queryClient.invalidateQueries({ queryKey: LEDGER_QK });
    };

    const handleReconcile = async (invoiceTxId: string, paymentTxId: string) => {
        try {
            const res = await apiClient.post('/platform/admin/financial/reconcile', { invoiceTxId, paymentTxId });
            if (res.ok) { showToast('Successfully matched transactions', 'success'); loadData(); }
        } catch (error) {
            console.error('Reconciliation failed', error);
        }
    };

    return { transactions, balances, loading, pAndL, balanceSheet, loadData, handleReconcile };
}

// --- Extracted from services.tsx ---
// Re-export from identity file: L5-Services.tsx
// removed broken export: export { default } from './L5-Services';


// --- Merged from L5-Services.tsx ---
// PAGE IDENTITY: L5 · Services
const cols_17: TableColumn[] = [
    { key: 'code', label: 'Code' }, { key: 'name', label: 'Service' },
    { key: 'rate', label: 'Rate' }, { key: 'clients', label: 'Clients' },
    { key: 'status', label: 'Status' },
];

export function Services() {
    return (
        <PageTemplate pageId="L5" title="🏥 Service Catalog" subtitle="All service types, billing rates, capacity & eligibility requirements"
            sectionData={PageSectionRegistry['L5']}
        />
    );
}

// --- Extracted from settings.tsx ---
// Re-export from identity file: T11-Settings.tsx
// removed broken export: export { default } from './T11-Settings';


// --- Merged from S8-MultiCurrencySettings.tsx ---
// ================================================================
// PAGE IDENTITY: S8 · Multi-Currency Settings
// Type: Settings | Owner: admin | Registry: S8
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function MultiCurrencySettings() {
    return (
        <PageTemplate
            pageId="S8"
            title="💱 Multi-Currency Settings"
            subtitle="Exchange rates, conversions & international billing"
            actionPageId="admin.multi-currency"
            sectionData={PageSectionRegistry['S8']}
        />
    );
}

// --- Merged from T11-Settings.tsx ---
// PAGE IDENTITY: T11 · Settings



export function Settings() {
    return (
        <PageTemplate pageId="T11" title="⚙️ Platform Settings" subtitle="General configuration, branding, integrations & system preferences"
            sectionData={PageSectionRegistry['T11']}
        />
    );
}

// --- Extracted from setup.tsx ---
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

// --- Extracted from sovereign.tsx ---
// --- Merged from T6-SovereignWallet.tsx ---
// PAGE IDENTITY: T6 · Sovereign Wallet

export function SovereignWallet() {
    return (
        <PageTemplate pageId="T6" title="🔐 Sovereign Wallet" subtitle="Decentralized identity, verifiable credentials & blockchain-based trust"
            sectionData={PageSectionRegistry['T6']}
        />
    );
}

// --- Extracted from strategy.tsx ---
// --- Merged from GrowthStrategy.tsx ---
export function GrowthStrategy() {
    return (
        <PageTemplate 
            pageId="PG-605" 
            title="Franchise Growth Model" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-605']}
        />
    );
}

// --- Extracted from supply-chain.tsx ---
const inventory = [
    { name: 'Nitrile Gloves (Box/100)', sku: 'PPE-001', qty: '450 boxes', reorder: 200, supplier: 'CleanPro Solutions', status: 'IN-STOCK' },
    { name: 'Surgical Masks (Box/50)', sku: 'PPE-002', qty: '120 boxes', reorder: 150, supplier: 'CleanPro Solutions', status: 'LOW' },
    { name: 'Blood Pressure Cuffs', sku: 'MED-010', qty: '35 units', reorder: 15, supplier: 'MedEquip Canada', status: 'IN-STOCK' },
    { name: 'Digital Thermometers', sku: 'MED-015', qty: '8 units', reorder: 20, supplier: 'MedEquip Canada', status: 'CRITICAL' },
    { name: 'Fall Detection Sensors', sku: 'IOT-001', qty: '22 units', reorder: 10, supplier: 'TechCare Devices', status: 'IN-STOCK' },
    { name: 'Hand Sanitizer (500ml)', sku: 'PPE-005', qty: '280 bottles', reorder: 100, supplier: 'CleanPro Solutions', status: 'IN-STOCK' },
    { name: 'Insulin Syringes (Box/100)', sku: 'MED-020', qty: '45 boxes', reorder: 50, supplier: 'Pharma Direct', status: 'LOW' },
];

const inventoryCols: TableColumn[] = [
    { key: 'name', label: 'Item' }, { key: 'sku', label: 'SKU' },
    { key: 'qty', label: 'Qty' }, { key: 'reorder', label: 'Reorder At' },
    { key: 'supplier', label: 'Supplier' }, { key: 'status', label: 'Status' },
];

const suppliers = [
    { icon: '🏢', title: 'MedEquip Canada', subtitle: 'Medical Supplies • ⭐ 4.8 • 45 orders' },
    { icon: '🏢', title: 'CleanPro Solutions', subtitle: 'Cleaning & PPE • ⭐ 4.5 • 32 orders' },
    { icon: '🏢', title: 'TechCare Devices', subtitle: 'IoT Devices • ⭐ 4.2 • 12 orders' },
    { icon: '🏢', title: 'Pharma Direct', subtitle: 'Pharmaceuticals • ⭐ 4.9 • 67 orders' },
    { icon: '🏢', title: 'Office Depot Canada', subtitle: 'Office Supplies • ⭐ 3.8 • 8 orders' },
];

const purchaseOrders = [
    { id: 'PO-2026-042', supplier: 'Pharma Direct', items: '5 items', total: '$2,340', status: 'DELIVERED', date: 'Mar 14' },
    { id: 'PO-2026-041', supplier: 'CleanPro Solutions', items: '3 items', total: '$890', status: 'SHIPPED', date: 'Mar 12' },
    { id: 'PO-2026-040', supplier: 'MedEquip Canada', items: '2 items', total: '$1,560', status: 'PENDING', date: 'Mar 10' },
    { id: 'PO-2026-039', supplier: 'TechCare Devices', items: '4 items', total: '$4,200', status: 'PROCESSING', date: 'Mar 8' },
];

const poCols: TableColumn[] = [
    { key: 'id', label: 'PO #' }, { key: 'supplier', label: 'Supplier' },
    { key: 'items', label: 'Items' }, { key: 'total', label: 'Total' },
    { key: 'status', label: 'Status' }, { key: 'date', label: 'Date' },
];

export function SupplyChainManagement() {
    const [tab, setTab] = useState('inventory');

    const tabContent: Record<string, Record<string, any>> = {
        inventory: { 'L25.inventory-table': { table: { columns: inventoryCols, rows: inventory } } },
        suppliers: { 'L25.supplier-list': { cardGrid: { items: suppliers, columns: 3 } } },
        orders: { 'L25.po-table': { table: { columns: poCols, rows: purchaseOrders } } },
    };

    return (
        <PageTemplate
            pageId="L25"
            title="📦 Supply Chain Management"
            subtitle="Inventory, suppliers, purchase orders & reorder automation"
            actionPageId="admin.supply-chain"
            sectionData={PageSectionRegistry['L25']}
        />
    );
}

// --- Extracted from support.tsx ---
export function SupportDashboard() {
    return (
        <PageTemplate 
            pageId="PG-828" 
            title="Support Inbox" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-828']}
        />
    );
}

// --- Extracted from telehealth.tsx ---
const sessionCols: TableColumn[] = [
    { key: 'patient', label: 'Patient' }, { key: 'type', label: 'Type' },
    { key: 'provider', label: 'Provider' }, { key: 'status', label: 'Status' },
    { key: 'time', label: 'Time' },
];

const rpmAlerts = [
    { id: '1', status: 'alert' as const, title: '🔴 Margaret Chen — BP 185/110 — Critical High', time: '2 min ago' },
    { id: '2', status: 'warning' as const, title: '🟡 Robert Williams — HR 112 bpm — Elevated', time: '8 min ago' },
    { id: '3', status: 'inactive' as const, title: '🟢 Susan Park — SpO2 97% — Normal range', time: '15 min ago' },
    { id: '4', status: 'inactive' as const, title: '🟢 James Brown — Glucose 108 mg/dL — Normal', time: '22 min ago' },
];

export function TelehealthCenter() {
    return (
        <PageTemplate
            pageId="H1"
            title="🩺 Telehealth & RPM Center"
            subtitle="Encrypted video consultations and live remote patient monitoring"
            actionPageId="admin.telehealth"
            isLive
            sectionData={PageSectionRegistry['H1']}
        />
    );
}

// --- Extracted from template-editor.tsx ---
// Re-export from identity file: T3-TemplateEditor.tsx
// removed broken export: export { default } from './T3-TemplateEditor';


// --- Merged from list.tsx ---
export function TemplatesList() {
    return (
        <PageTemplate 
            pageId="PGE-TL" 
            title="✨ Templates List" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-TL']}
        />
    );
}

// --- Merged from T3-TemplateEditor.tsx ---
// PAGE IDENTITY: T3 · Template Editor



export function TemplateEditor() {
    return (
        <PageTemplate pageId="T3" title="🎨 Template Editor" subtitle="Design & manage email, SMS, PDF & form templates"
            sectionData={PageSectionRegistry['T3']}
        />
    );
}

// --- Extracted from timesheet-adjustment.tsx ---
// Barrel re-export — identity file: F8-TimesheetAdjustment.tsx
// removed broken export: export { default } from './F8-TimesheetAdjustment';


// --- Merged from F8-TimesheetAdjustment.tsx ---
// PAGE IDENTITY: F8 · Timesheet Adjustment
const cols_18: TableColumn[] = [
    { key: 'id', label: 'ID' }, { key: 'psw', label: 'PSW' },
    { key: 'date', label: 'Date' }, { key: 'original', label: 'Original' },
    { key: 'adjusted', label: 'Adjusted' }, { key: 'reason', label: 'Reason' },
    { key: 'status', label: 'Status' },
];

export function TimesheetAdjustment() {
    return (
        <PageTemplate pageId="F8" title="⏱️ Timesheet Adjustments" subtitle="Review and process PSW timesheet corrections & overtime adjustments"
            sectionData={PageSectionRegistry['F8']}
        />
    );
}

// --- Extracted from timesheets.tsx ---
// Re-export from identity file: L4-Timesheets.tsx
// removed broken export: export { default } from './L4-Timesheets';


// --- Merged from L4-Timesheets.tsx ---
// PAGE IDENTITY: L4 · Timesheets
const cols_19: TableColumn[] = [
    { key: 'psw', label: 'PSW' }, { key: 'period', label: 'Period' },
    { key: 'regular', label: 'Regular' }, { key: 'ot', label: 'Overtime' },
    { key: 'total', label: 'Total' }, { key: 'status', label: 'Status' },
];

export function Timesheets() {
    return (
        <PageTemplate pageId="L4" title="⏱️ Timesheets" subtitle="PSW timesheet submissions, approval workflows & payroll integration"
            sectionData={PageSectionRegistry['L4']}
        />
    );
}

// --- Extracted from users.tsx ---
// removed re-export: export { UserList, UserEntry };


// --- Merged from F9a-UserEntry.tsx ---
// PAGE IDENTITY: F9a · User Entry



export function UserEntry() {
    return (
        <PageTemplate pageId="F9a" title="➕ New User" subtitle="Create new platform user with role assignment & access configuration"
            sectionData={PageSectionRegistry['F9a']}
        />
    );
}

// --- Merged from L3a-UserList.tsx ---
// PAGE IDENTITY: L3a · User List
const cols_20: TableColumn[] = [
    { key: 'name', label: 'Name' }, { key: 'email', label: 'Email' },
    { key: 'role', label: 'Role' }, { key: 'status', label: 'Status' },
    { key: 'lastLogin', label: 'Last Login' },
];

export function UserList() {
    return (
        <PageTemplate pageId="L3a" title="👥 User Management" subtitle="All platform users, roles, status & access management"
            sectionData={PageSectionRegistry['L3a']}
        />
    );
}
// --- Merged sidecars ---

/* Merged from userHandlers.ts */
// L3a UserList: User interface and API handlers extracted

export interface User {
    id: string; email: string; roles: string[];
    profile?: { fullName: string; isVerified?: boolean; };
}

export async function fetchUsers(t: (key: string) => string, fallbackLabel: string): Promise<User[]> {
    try { const response = await apiClient.get(ApiRegistry.ADMIN.USERS); if (response.ok) { const data = await response.json(); return data.map((u: any) => ({ id: u.id, email: u.email, roles: u.roles || (u.role ? [u.role] : []), profile: { fullName: u.pswProfile?.fullName || u.clientProfile?.fullName || u.profile?.fullName || fallbackLabel, isVerified: u.status === 'verified' } })); } } catch { /* handled by caller */ } return []; }

export async function approveUser(id: string): Promise<boolean> {
    try { const res = await apiClient.post(ApiRegistry.ADMIN.USERS_VERIFY(id)); return res.ok; } catch { return false; }
}

export async function inviteUser(email: string): Promise<void> {
    const res = await apiClient.post('/v1/admin/users/invite', { email });
    if (!res.ok) { const data = await res.json().catch(() => ({})); throw new Error((data as any).error || 'Invite failed'); }
}

// --- Extracted from webhooks.tsx ---
// --- Merged from L11-WebhookList.tsx ---
// PAGE IDENTITY: L11 · Webhook List
const cols_1: TableColumn[] = [
    { key: 'name', label: 'Webhook' }, { key: 'url', label: 'URL' },
    { key: 'events', label: 'Events' }, { key: 'status', label: 'Status' },
    { key: 'lastDelivery', label: 'Last Delivery' },
];

export function WebhookList() {
    return (
        <PageTemplate pageId="L11" title="🔗 Webhooks" subtitle="Outbound webhook endpoints, event subscriptions & delivery logs"
            sectionData={PageSectionRegistry['L11']}
        />
    );
}

// --- Merged from T51-WebhookDeliveries.tsx ---
// PAGE IDENTITY: T51 · Webhook Deliveries
const cols_2_webhook: TableColumn[] = [
    { key: 'time', label: 'Time' }, { key: 'webhook', label: 'Webhook' },
    { key: 'event', label: 'Event' }, { key: 'status', label: 'Status' },
    { key: 'duration', label: 'Duration' },
];

export function WebhookDeliveries() {
    return (
        <PageTemplate pageId="T51" title="📡 Webhook Deliveries" subtitle="Delivery logs, retry status & failure analysis"
            sectionData={PageSectionRegistry['T51']}
        />
    );
}

// --- Extracted from reconciliation.tsx ---
// Re-export from identity file: T59-Reconciliation.tsx
// removed broken export: export { default } from './T59-Reconciliation';


// --- Merged from T59-Reconciliation.tsx ---
// ================================================================
// PAGE IDENTITY: T59 · Reconciliation
// Type: Tool | Owner: admin
// Converted: FuzzyMatcher inlined — old ./components/ removed
// ================================================================
const cols_21: TableColumn[] = [
    { key: 'id', label: 'Feed ID' }, { key: 'bank', label: 'Bank' },
    { key: 'description', label: 'Description' }, { key: 'amount', label: 'Amount' },
    { key: 'match', label: 'Ledger Match' }, { key: 'confidence', label: 'Confidence' },
];

export function FinancialReconciliation() {
    return (
        <PageTemplate pageId="T59" title="🛡️ Financial Reconciliation Hub" subtitle="Verify the ledger against bank feeds — fuzzy matching, auto-reconciliation & audit trail"
            sectionData={PageSectionRegistry['T59']}
        />
    );
}

// --- Extracted from scheduleApi.ts ---
export const API_URL_22 = import.meta.env.VITE_API_URL || 'http://localhost:8787';

export interface Visit_2 {
    id: string; requestedStartAt: string; durationMinutes: number;
    client: { fullName: string }; psw?: { fullName: string }; assignedPswId?: string;
    status: string; isSurgeActive?: boolean; surgeMultiplier?: number;
    service?: { providerRateHourly?: string | number };
}

export const getStatusColor_2 = (status: string): string => {
    switch (status.toLowerCase()) {
        case 'requested': return '#f57c00'; case 'scheduled': return '#1976d2';
        case 'completed': return '#388e3c'; case 'posted': return '#8e24aa';
        case 'offered': return '#00acc1'; case 'accepted': return '#43a047';
        default: return '#9e9e9e';
    }
}

export async function apiFetchVisits(statusFilter?: string | null): Promise<{ visits: Visit[]; events: any[] }> {
    const token = localStorage.getItem('token');
    const res = await fetch(`${API_URL_13}${ApiRegistry.ADMIN.VISITS}`, { headers: { Authorization: `Bearer ${token}` } });
    const data = await res.json();
    if (!Array.isArray(data)) return { visits: [], events: [] };
    const filtered = statusFilter ? data.filter((v: Visit) => v.status.toLowerCase() === statusFilter.toLowerCase()) : data;
    const events = filtered.map((v: Visit) => {
        const start = new Date(v.requestedStartAt); const end = new Date(start.getTime() + v.durationMinutes * 60000);
        return { id: v.id, title: `${v.client?.fullName || 'Unknown Client'} (${v.status})`, start, end, resource: v, style: { backgroundColor: getStatusColor(v.status) } };
    });
    return { visits: filtered, events };
}

export async function apiFetchPsws(): Promise<any[]> {
    const token = localStorage.getItem('token');
    const res = await fetch(`${API_URL_13}${ApiRegistry.ADMIN.USERS}`, { headers: { Authorization: `Bearer ${token}` } });
    const data = await res.json();
    return Array.isArray(data) ? data.filter((u: any) => u.role === 'psw') : [];
}

export async function apiAssignVisit(visitId: string, pswId: string): Promise<boolean> {
    const token = localStorage.getItem('token');
    const res = await fetch(`${API_URL_13}${ApiRegistry.ADMIN.VISITS_ASSIGN}`, { method: 'POST', headers: { 'Authorization': `Bearer ${token}`, 'Content-Type': 'application/json' }, body: JSON.stringify({ visitId, pswId }) });
    return res.ok;
}

export async function apiOfferVisit(visitId: string, pswIds: string[]): Promise<boolean> {
    const token = localStorage.getItem('token');
    const res = await fetch(`${API_URL_13}${ApiRegistry.ADMIN.VISITS_UPDATE(visitId)}/offer`, { method: 'POST', headers: { 'Authorization': `Bearer ${token}`, 'Content-Type': 'application/json' }, body: JSON.stringify({ pswIds }) });
    return res.ok;
}

export async function apiFetchSuggestions(visitId: string): Promise<any[]> {
    const token = localStorage.getItem('token');
    const res = await fetch(`${API_URL_13}${ApiRegistry.ADMIN.VISITS_UPDATE(visitId)}/suggest`, { headers: { Authorization: `Bearer ${token}` } });
    return await res.json();
}

export async function apiApplySurge(visitId: string, multiplier: number, active: boolean): Promise<boolean> {
    const token = localStorage.getItem('token');
    const res = await fetch(`${API_URL_13}/api/v1/admin/visits/${visitId}/surge`, { method: 'PATCH', headers: { 'Authorization': `Bearer ${token}`, 'Content-Type': 'application/json' }, body: JSON.stringify({ surgeMultiplier: multiplier, isSurgeActive: active }) });
    return res.ok;
}

export async function apiDeleteVisit(visitId: string): Promise<boolean> {
    const token = localStorage.getItem('token');
    const res = await fetch(`${API_URL_13}${ApiRegistry.ADMIN.VISITS_UPDATE(visitId)}`, { method: 'DELETE', headers: { 'Authorization': `Bearer ${token}` } });
    return res.ok;
}

// --- Extracted from useScheduleLogic.ts ---
export type { Visit };
export { getStatusColor };

export const useScheduleLogic = () => {
    const { t } = useTranslation();
    const { showToast } = useNotification();
    const [searchParams] = useSearchParams();

    const [events, setEvents] = useState<any[]>([]);
    const [visits, setVisits] = useState<Visit[]>([]);
    const [psws, setPsws] = useState<any[]>([]);
    const [selectedVisit, setSelectedVisit] = useState<Visit | null>(null);
    const [isAssignModalOpen, setIsAssignModalOpen] = useState(false);
    const [assignedPswId, setAssignedPswId] = useState('');
    const [isCreateVisitModalOpen, setIsCreateVisitModalOpen] = useState(false);
    const [viewMode, setViewMode] = useState<'calendar' | 'list'>('calendar');
    const [suggestions, setSuggestions] = useState<any[]>([]);
    const [isSuggesting, setIsSuggesting] = useState(false);
    const [isSurgeModalOpen, setIsSurgeModalOpen] = useState(false);
    const [surgeTargetVisit, setSurgeTargetVisit] = useState<Visit | null>(null);

    const fetchVisits = async () => { try { const { visits: v, events: e } = await apiFetchVisits(searchParams.get('status')); setVisits(v); setEvents(e); } catch (err) { console.error(err); } };
    const fetchPsws = async () => { try { setPsws(await apiFetchPsws()); } catch (err) { console.error(err); } };

    const handleAssign = async () => {
        if (!selectedVisit || !assignedPswId) return;
        try { if (await apiAssignVisit(selectedVisit.id, assignedPswId)) { setIsAssignModalOpen(false); fetchVisits(); showToast(t(ContentRegistry.SCHEDULE.MESSAGES.SUCCESS_ASSIGN), 'success'); } }
        catch { showToast(t(ContentRegistry.SCHEDULE.MESSAGES.ERROR_ASSIGN), 'error'); }
    };

    const fetchSuggestions = async () => {
        if (!selectedVisit) return; setIsSuggesting(true);
        try { setSuggestions(await apiFetchSuggestions(selectedVisit.id)); } catch (err) { console.error(err); } finally { setIsSuggesting(false); }
    };

    const handleOffer = async (pswIds: string[]) => {
        if (!selectedVisit) return;
        try { if (await apiOfferVisit(selectedVisit.id, pswIds)) { showToast(t(ContentRegistry.SCHEDULE.MESSAGES.OFFERS_SENT), 'success'); setIsAssignModalOpen(false); fetchVisits(); } }
        catch { showToast(t(ContentRegistry.SCHEDULE.MESSAGES.OFFERS_FAILED), 'error'); }
    };

    const handleApplySurge = async (visitId: string, surgeMultiplier: number, isSurgeActive: boolean) => {
        try { if (await apiApplySurge(visitId, surgeMultiplier, isSurgeActive)) { showToast(t(ContentRegistry.SCHEDULE.MESSAGES.SURGE_SUCCESS), 'success'); setIsSurgeModalOpen(false); fetchVisits(); } else { showToast(t(ContentRegistry.SCHEDULE.MESSAGES.SURGE_ERROR), 'error'); } }
        catch { showToast(t(ContentRegistry.SCHEDULE.MESSAGES.NETWORK_ERROR), 'error'); }
    };

    const handleDeleteVisit = async () => {
        if (!selectedVisit) return;
        if (!confirm(t(ContentRegistry.SCHEDULE.MODAL.CONFIRM_DELETE))) return;
        try { if (await apiDeleteVisit(selectedVisit.id)) { setIsAssignModalOpen(false); fetchVisits(); showToast(t(ContentRegistry.SCHEDULE.MESSAGES.SUCCESS_CANCEL), 'success'); } }
        catch { showToast(t(ContentRegistry.SCHEDULE.MESSAGES.ERROR_DELETE), 'error'); }
    };

    const handleSelectEvent = (event: any) => { const visit = event.resource; setSelectedVisit(visit); setAssignedPswId(visit.assignedPswId || ''); setIsAssignModalOpen(true); };

    useEffect(() => { fetchVisits(); fetchPsws(); }, [searchParams]);

    return {
        events, visits, psws, selectedVisit, isAssignModalOpen, assignedPswId,
        isCreateVisitModalOpen, viewMode, suggestions, isSuggesting,
        isSurgeModalOpen, surgeTargetVisit,
        setSelectedVisit, setIsAssignModalOpen, setAssignedPswId,
        setIsCreateVisitModalOpen, setViewMode, setIsSurgeModalOpen, setSurgeTargetVisit,
        fetchVisits, fetchPsws, handleAssign, fetchSuggestions, handleOffer,
        handleApplySurge, handleDeleteVisit, handleSelectEvent, getStatusColor
    };
};
export const AdminRoutes = () => (
        <Route path={RouteRegistry.ADMIN.DASHBOARD} element={<RequireRole allowedRoles={['admin', 'finance_director']}><AppLayout /></RequireRole>}>
            <Route index element={<AdminDashboard />} />
            <Route path={RouteRegistry.ADMIN.SUMMARY_DASHBOARD} element={<RegistrySummary />} />
            <Route path={RouteRegistry.ADMIN.USERS} element={<UserList />} />
            <Route path={RouteRegistry.ADMIN.USERS_NEW} element={<UserEntry />} />
            <Route path={RouteRegistry.ADMIN.USERS_EDIT(':id')} element={<UserEntry />} />
            <Route path={RouteRegistry.ADMIN.SCHEDULE} element={<Schedule />} />
            <Route path={RouteRegistry.ADMIN.EARNINGS} element={<AdminEarningsPage />} />
            <Route path={RouteRegistry.ADMIN.INCIDENTS} element={<IncidentList />} />
            <Route path={RouteRegistry.ADMIN.INCIDENTS_NEW} element={<IncidentEntry />} />
            <Route path={RouteRegistry.ADMIN.INCIDENTS_EDIT(':id')} element={<IncidentEntry />} />
            <Route path={RouteRegistry.ADMIN.TIMESHEETS} element={<Timesheets />} />
            <Route path={RouteRegistry.ADMIN.TIMESHEET_ADJUST} element={<TimesheetAdjustment />} />
            <Route path={RouteRegistry.ADMIN.LEADS} element={<LeadList />} />
            <Route path={RouteRegistry.ADMIN.LEADS_NEW} element={<LeadEntryForm />} />
            <Route path={RouteRegistry.ADMIN.LEADS_EDIT(':id')} element={<LeadEntryForm />} />
            <Route path={RouteRegistry.ADMIN.LEADS_CONVERT(':id')} element={<LeadConversion />} />
            <Route path={RouteRegistry.ADMIN.OPERATIONS.LOGISTICS_HUB} element={<div />} />
            <Route path={RouteRegistry.ADMIN.OPERATIONS.REGION_MAPPING} element={<div />} />
            <Route path={RouteRegistry.ADMIN.OPERATIONS.REALTIME_CAPACITY} element={<div />} />
            <Route path={RouteRegistry.ADMIN.SERVICES} element={<Services />} />
            <Route path={RouteRegistry.ADMIN.SETTINGS} element={<Settings />} />
            <Route path={RouteRegistry.ADMIN.CONTENT} element={<ContentManager />} />
            <Route path={RouteRegistry.ADMIN.AUDITS} element={<AuditLogs />} />
            <Route path={RouteRegistry.ADMIN.ADMISSION} element={<div />} />
            <Route path={RouteRegistry.ADMIN.ONBOARDING} element={<div />} />
            <Route path={RouteRegistry.ADMIN.REPORTS} element={<ReportCenter />} />
            <Route path={RouteRegistry.ADMIN.INVOICES_NEW} element={<div />} />
            <Route path={RouteRegistry.ADMIN.INVOICES_EDIT(':id')} element={<div />} />
            <Route path={RouteRegistry.ADMIN.SETUP_WIZARD} element={<BusinessSetupWizard />} />
            <Route path={RouteRegistry.ADMIN.WIZARD_HUB} element={<WizardHub />} />
            <Route path={RouteRegistry.ADMIN.STAFF_ONBOARDING} element={<StaffOnboardingWizard />} />
            <Route path={RouteRegistry.ADMIN.CARE_PLAN_WIZARD} element={<CarePlanWizard />} />
            <Route path={RouteRegistry.ADMIN.REVENUE_WIZARD} element={<RevenueWizard />} />
            <Route path={RouteRegistry.ADMIN.BUSINESS_MODEL_WIZARD} element={<BusinessModelWizard />} />
            <Route path={RouteRegistry.ADMIN.BUSINESS_STATUS} element={<BusinessStatus />} />
            <Route path={RouteRegistry.ADMIN.CUSTOMERS} element={<div />} />
            <Route path={RouteRegistry.ADMIN.TEMPLATE_EDITOR} element={<TemplateEditor />} />
            <Route path={RouteRegistry.ADMIN.SEARCH} element={<SearchPage />} />
            <Route path={RouteRegistry.ADMIN.REPORT_EXPORT} element={<ExportPage />} />
            <Route path={RouteRegistry.ADMIN.ERP.INVENTORY} element={<SupplyChainHub />} />
            <Route path={RouteRegistry.ADMIN.ERP.PROCUREMENT} element={<SupplyChainHub />} />
            <Route path={RouteRegistry.ADMIN.TELEHEALTH.CENTER} element={<TelehealthCenter />} />
            <Route path={RouteRegistry.ADMIN.TELEHEALTH.ALERTS} element={<TelehealthCenter />} />
            <Route path={RouteRegistry.ADMIN.RCM.CLAIMS} element={<RevenueCycleHub />} />
            <Route path={RouteRegistry.ADMIN.RCM.REVENUE} element={<RevenueCycleHub />} />
            <Route path={RouteRegistry.ADMIN.PHARMACY.HUB} element={<PharmacyHub />} />
            <Route path={RouteRegistry.ADMIN.PHARMACY.MAR} element={<PharmacyHub />} />
            <Route path={RouteRegistry.ADMIN.SECURITY.GOVERNANCE} element={<SecurityGovernance />} />
            <Route path={RouteRegistry.ADMIN.SECURITY.DEVICE_REGISTRY} element={<DeviceManagement />} />
            <Route path={RouteRegistry.ADMIN.SECURITY.FORENSIC_TRAILS} element={<ForensicTrails />} />
            <Route path={RouteRegistry.ADMIN.SECURITY.CORS_SETTINGS} element={<CorsSettings />} />
            <Route path={RouteRegistry.ADMIN.SECURITY.INTEGRITY_SCAN} element={<IntegrityVerification />} />
            <Route path={RouteRegistry.ADMIN.SECURITY.FINANCIAL_LEDGER} element={<FinancialLedger />} />
            <Route path={RouteRegistry.ADMIN.SECURITY.TAX_HUB} element={<TaxComplianceHub />} />
            <Route path={RouteRegistry.ADMIN.FINANCE.DASHBOARD} element={<AccountingDashboard />} />
            <Route path={RouteRegistry.ADMIN.FINANCE.RECONCILIATION} element={<FinancialReconciliation />} />
            <Route path={RouteRegistry.ADMIN.NOTIFICATIONS_HUB} element={<NotificationsHub />} />
            <Route path={RouteRegistry.ADMIN.DOCUMENT_CENTER} element={<DocumentCenter />} />
            <Route path={RouteRegistry.ADMIN.PAYROLL_HUB} element={<PayrollHub />} />
            <Route path={RouteRegistry.ADMIN.BOOKING_REQUESTS} element={<BookingRequestQueue />} />
            <Route path={RouteRegistry.ADMIN.REFERENCE_DATA} element={<ReferenceDataHub />} />
            <Route path={RouteRegistry.ADMIN.CRON_DASHBOARD} element={<CronDashboard />} />
            <Route path={RouteRegistry.ADMIN.FORM_REGISTRY} element={<FormRegistryPage />} />
            <Route path={RouteRegistry.ADMIN.PAGE_REGISTRY} element={<PageRegistryPage />} />
                <Route path={RouteRegistry.ADMIN.EVV.DASHBOARD} element={<div />} />
            <Route path={RouteRegistry.ADMIN.EVV.EXCEPTIONS} element={<EvvExceptions />} />
            <Route path={RouteRegistry.ADMIN.EVV.EXPORT} element={<EvvExport />} />
            <Route path={RouteRegistry.ADMIN.AUTHORIZATIONS.LIST} element={<AuthList />} />
            <Route path={RouteRegistry.ADMIN.AUTHORIZATIONS.ALERTS} element={<AuthAlerts />} />
            <Route path={RouteRegistry.ADMIN.AUTHORIZATIONS.UTILIZATION(':clientId')} element={<AuthUtilization />} />
            <Route path={RouteRegistry.ADMIN.CONSENT.LIST} element={<ConsentList />} />
            <Route path={RouteRegistry.ADMIN.CONSENT.TEMPLATES} element={<ConsentTemplates />} />
            <Route path={RouteRegistry.ADMIN.CONSENT.EXPIRING} element={<ConsentExpiring />} />
            <Route path={RouteRegistry.ADMIN.REFERRALS.LIST} element={<ReferralList />} />
            <Route path={RouteRegistry.ADMIN.REFERRALS.ANALYTICS} element={<ReferralAnalytics />} />
            <Route path={RouteRegistry.ADMIN.CLAIMS.LIST} element={<ClaimsList />} />
            <Route path={RouteRegistry.ADMIN.CLAIMS.ERA} element={<ClaimsEra />} />
            <Route path={RouteRegistry.ADMIN.WEBHOOKS.LIST} element={<WebhookList />} />
            <Route path={RouteRegistry.ADMIN.WEBHOOKS.DELIVERIES} element={<WebhookDeliveries />} />
            <Route path={RouteRegistry.ADMIN.AUDIT_EXPORT.DOWNLOAD} element={<AuditDownload />} />
            <Route path={RouteRegistry.ADMIN.AUDIT_EXPORT.COMPLIANCE} element={<ComplianceExport />} />
            <Route path={RouteRegistry.ADMIN.AUDIT_EXPORT.REGULATORY} element={<RegulatoryExport />} />
            <Route path={RouteRegistry.ADMIN.AI.DASHBOARD} element={<div />} />
            <Route path={RouteRegistry.ADMIN.AI.PREDICTIVE_ANALYTICS} element={<PredictiveAnalytics />} />
            <Route path={RouteRegistry.ADMIN.AI.CHURN_RISK} element={<ChurnRisk />} />
            <Route path={RouteRegistry.ADMIN.AI.VISIT_OPTIMIZATION} element={<VisitOptimization />} />
            <Route path={RouteRegistry.ADMIN.AI.SENTIMENT_ANALYSIS} element={<SentimentAnalysis />} />
            <Route path={RouteRegistry.ADMIN.SECURITY.PERMISSION_GRID} element={<PermissionGrid />} />
            <Route path={RouteRegistry.ADMIN.SECURITY.SESSION_MONITOR} element={<SessionMonitor />} />
            <Route path={RouteRegistry.ADMIN.SECURITY.THREAT_DETECTION} element={<ThreatDetection />} />
            <Route path={RouteRegistry.ADMIN.OPERATIONS.CENTER} element={<OperationsCenter />} />
            <Route path={RouteRegistry.ADMIN.OPERATIONS.SUPPLY_DEMAND} element={<SupplyDemand />} />
            {/* NEW PREMIUM PAGES */}
            <Route path={RouteRegistry.ADMIN.AI_COMMAND} element={<div />} />
            <Route path={RouteRegistry.ADMIN.MULTI_CURRENCY} element={<MultiCurrencySettings />} />
            <Route path={RouteRegistry.ADMIN.AUDIT_TRAIL} element={<AuditTrailViewer />} />
            <Route path={RouteRegistry.ADMIN.FRANCHISE} element={<FranchiseManagement />} />
            <Route path={RouteRegistry.ADMIN.SUPPLY_CHAIN} element={<SupplyChainManagement />} />
        </Route>
    );
