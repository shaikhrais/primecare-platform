import { apiClient } from '@/shared/utils/apiClient';
import { useRegistryQuery } from '@/shared/hooks/useRegistryQuery';
import AppLayout from "@/shared/components/layout/AppLayout";
import { TableColumn, TabItem } from "@/shared/components/sections";
import { PageTemplate } from "@/shared/components/ui/PageTemplate";
import { useDialog } from "@/shared/hooks/useDialog";
import { useToast } from "@/shared/hooks/useToast";
import RequireRole from "@/shared/rbac/RequireRole";
import { useQueryClient } from "@tanstack/react-query";
import { FileText, Search, LayoutGrid, Filter, BarChart3, ClipboardList, Layers, Compass, Wand2, Wrench, Globe, BookOpen, AlertTriangle, Network, List, Box, Database, UserPlus, FileSignature, Activity, Send, MapPin } from "lucide-react";
import { AdminRegistry, FormEntry, PageType, PageEntry, MasterEntry } from "prime-care-shared";
import React, { lazy, useState, useMemo, useEffect } from "react";
import { useTranslation } from "react-i18next";
import { Route, useNavigate, useSearchParams } from "react-router";
import { PageSectionRegistry } from "./shared";

// --- Merged from admin.tsx ---
const { RouteRegistry, ApiRegistry, ContentRegistry, ThemeRegistry, PageRegistry, FormRegistry } = AdminRegistry;


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
        <PageTemplate 
            pageId="PGE-ClientAdmission" 
            
            sectionData={PageSectionRegistry['ClientAdmission']}
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
            pageId="PGE-ChurnRisk" 
            actionPageId="admin.churn-risk"
            sectionData={PageSectionRegistry['ChurnRisk']}
        />
    );
}

// --- Merged from T54-VisitOptimization.tsx ---
// ================================================================
// PAGE IDENTITY: T54 · Visit Optimization
// Type: Tool | Owner: admin | Registry: T54
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

const VisitComponent = (props: any) => <></>;
export function VisitOptimization() {
    return (
        <PageTemplate 
            pageId="PGE-VisitOptimization" 
            actionPageId="admin.visit-optimization"
            sectionData={PageSectionRegistry['VisitOptimization']}
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
            pageId="PGE-SentimentAnalysis" 
            actionPageId="admin.sentiment-analysis"
            sectionData={PageSectionRegistry['SentimentAnalysis']}
        />
    );
}

// --- Extracted from audit-export.tsx ---
// --- Merged from R10-ComplianceExport.tsx ---
// PAGE IDENTITY: R10 · Compliance Export

export function ComplianceExport() {
    return (
        <PageTemplate 
            pageId="PGE-ComplianceExport" 
            
            sectionData={PageSectionRegistry['ComplianceExport']}
        />
    );
}

// --- Merged from R13-RegulatoryExport.tsx ---
// PAGE IDENTITY: R13 · Regulatory Export

export function RegulatoryExport() {
    return (
        <PageTemplate 
            pageId="PGE-RegulatoryExport" 
            
            sectionData={PageSectionRegistry['RegulatoryExport']}
        />
    );
}

// --- Merged from R9-AuditDownload.tsx ---
// PAGE IDENTITY: R9 · Audit Download | R10 · Compliance Export | R13 · Regulatory Export

export function AuditDownload() {
    return (
        <PageTemplate 
            pageId="PGE-AuditDownload" 
            
            sectionData={PageSectionRegistry['AuditDownload']}
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
        <PageTemplate 
            pageId="PGE-AuditLogs" 
            actionPageId="admin.audit-logs"
            sectionData={PageSectionRegistry['AuditLogs']}
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
        <PageTemplate 
            pageId="PGE-AuthList" 
            actionPageId="admin.authorizations"
            sectionData={PageSectionRegistry['AuthList']}
        />
    );
}

// --- Merged from R6-AuthUtilization.tsx ---
// PAGE IDENTITY: R6 · Auth Utilization | T49 · Auth Alerts

export function AuthUtilization() {
    return (
        <PageTemplate 
            pageId="PGE-AuthUtilization" 
            
            sectionData={PageSectionRegistry['AuthUtilization']}
        />
    );
}

// --- Merged from T49-AuthAlerts.tsx ---
// PAGE IDENTITY: T49 · Authorization Alerts

export function AuthAlerts() {
    return (
        <PageTemplate 
            pageId="PGE-AuthAlerts" 
            
            sectionData={PageSectionRegistry['AuthAlerts']}
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
            pageId="PGE-AutoPilotDashboard" 
            actionPageId="admin.autopilot"
            sectionData={PageSectionRegistry['AutoPilotDashboard']}
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
        <PageTemplate 
            pageId="PGE-BookingRequestQueue" 
            
            sectionData={PageSectionRegistry['BookingRequestQueue']}
        />
    );
}

// --- Extracted from claims.tsx ---
// --- Merged from L10-ClaimsList.tsx ---
// PAGE IDENTITY: L10 · Claims List

export function ClaimsList() {
    return (
        <PageTemplate 
            pageId="PGE-ClaimsList" 
            actionPageId="admin.claims"
            sectionData={PageSectionRegistry['ClaimsList']}
        />
    );
}

// --- Merged from R12-ClaimsEra.tsx ---
// PAGE IDENTITY: R12 · Claims ERA

export function ClaimsEra() {
    return (
        <PageTemplate 
            pageId="PGE-ClaimsEra" 
            
            sectionData={PageSectionRegistry['ClaimsEra']}
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
            pageId="PGE-ClinicalAssistant" 
            actionPageId="admin.clinical-assistant"
            sectionData={PageSectionRegistry['ClinicalAssistant']}
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
        <PageTemplate 
            pageId="PGE-SMSHub" 
            
            sectionData={PageSectionRegistry['SMSHub']}
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
        <PageTemplate 
            pageId="PGE-ConsentList" 
            
            sectionData={PageSectionRegistry['ConsentList']}
        />
    );
}

// --- Merged from R7-ConsentExpiring.tsx ---
// PAGE IDENTITY: R7 · Consent Expiring Report

export function ConsentExpiring() {
    return (
        <PageTemplate 
            pageId="PGE-ConsentExpiring" 
            
            sectionData={PageSectionRegistry['ConsentExpiring']}
        />
    );
}

// --- Merged from T50-ConsentTemplates.tsx ---
// PAGE IDENTITY: T50 · Consent Templates

export function ConsentTemplates() {
    return (
        <PageTemplate 
            pageId="PGE-ConsentTemplates" 
            
            sectionData={PageSectionRegistry['ConsentTemplates']}
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
        <PageTemplate pageId="T2"  
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
        <PageTemplate 
            pageId="PGE-CustomerList" 
            
            sectionData={PageSectionRegistry['CustomerList']}
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

const Visit = (props: any) => <></>;

export function AdminDashboard() {
    return (
        <PageTemplate 
            pageId="PGE-AdminDashboard" 
            actionPageId="admin.dashboard"
            sectionData={PageSectionRegistry['AdminDashboard']}
        />
    );
}

// --- Merged from D2-RegistrySummary.tsx ---
// PAGE IDENTITY: D2 · Registry Summary

export function RegistrySummary() {
    return (
        <PageTemplate 
            pageId="PGE-RegistrySummary" 
            
            sectionData={PageSectionRegistry['RegistrySummary']}
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
        <PageTemplate 
            pageId="PGE-DocumentCenter" 
            actionPageId="admin.documents"
            sectionData={PageSectionRegistry['DocumentCenter']}
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
        <PageTemplate 
            pageId="PGE-AdminEarningsPage" 
            
            sectionData={PageSectionRegistry['AdminEarningsPage']}
        />
    );
}

// --- Extracted from erp.tsx ---
// --- Merged from H4-SupplyChainHub.tsx ---
// PAGE IDENTITY: H4 · Supply Chain / ERP Hub

export function SupplyChainHub() {
    return (
        <PageTemplate 
            pageId="PGE-SupplyChainHub" 
            
            sectionData={PageSectionRegistry['SupplyChainHub']}
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
        <PageTemplate 
            pageId="PGE-EvvExceptions" 
            
            sectionData={PageSectionRegistry['EvvExceptions']}
        />
    );
}

// --- Merged from R8-EvvExport.tsx ---
// PAGE IDENTITY: R8 · EVV Export

export function EvvExport() {
    return (
        <PageTemplate 
            pageId="PGE-EvvExport" 
            
            sectionData={PageSectionRegistry['EvvExport']}
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
                        <div className="text-2xl font-bold">0</div> forms · {formsWithDeps.length} with inline creators · {categories.length} categories
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



// --- Merged from FormCard.tsx ---
export function FormCard() {
    return (
        <PageTemplate 
            pageId="PGE-FormCard" 
            
            sectionData={PageSectionRegistry['FormCard']}
        />
    );
}

// --- Merged from FormDetailView.tsx ---
export function FormDetailView() {
    return (
        <PageTemplate 
            pageId="PGE-FormDetailView" 
            
            sectionData={PageSectionRegistry['FormDetailView']}
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
        <PageTemplate 
            pageId="PGE-IncidentEntry" 
            
            sectionData={PageSectionRegistry['IncidentEntry']}
        />
    );
}

// --- Merged from IncidentEntry.tsx ---
export function IncidentEntryForm() {
    return (
        <PageTemplate 
            pageId="PGE-IncidentEntryForm" 
            
            sectionData={PageSectionRegistry['IncidentEntryForm']}
        />
    );
}

// --- Merged from IncidentList.tsx ---
export function IncidentList_OLD1() {
    return (
        <PageTemplate 
            pageId="PGE-IncidentList_OLD1" 
            
            sectionData={PageSectionRegistry['IncidentList_OLD1']}
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
        <PageTemplate 
            pageId="PGE-IncidentList" 
            
            sectionData={PageSectionRegistry['IncidentList']}
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
        <PageTemplate 
            pageId="PGE-AiInsights" 
            
            sectionData={PageSectionRegistry['AiInsights']}
        />
    );
}

// --- Extracted from interoperability.tsx ---
// --- Merged from T5-FHIRCenter.tsx ---
// PAGE IDENTITY: T5 · FHIR Interoperability Center

export function FHIRCenter() {
    return (
        <PageTemplate 
            pageId="PGE-FHIRCenter" 
            
            sectionData={PageSectionRegistry['FHIRCenter']}
        />
    );
}

// --- Extracted from invoices.tsx ---
// removed re-export: export { InvoiceEntry };


// --- Merged from F9-InvoiceEntry.tsx ---
// PAGE IDENTITY: F9 · Invoice Entry



export function InvoiceEntry() {
    return (
        <PageTemplate 
            pageId="PGE-InvoiceEntry" 
            
            sectionData={PageSectionRegistry['InvoiceEntry']}
        />
    );
}

// --- Extracted from knowledge-base.tsx ---
// --- Merged from H8-KnowledgeBase.tsx ---
// PAGE IDENTITY: H8 · Knowledge Base

export function KnowledgeBase() {
    return (
        <PageTemplate 
            pageId="PGE-KnowledgeBase" 
            
            sectionData={PageSectionRegistry['KnowledgeBase']}
        />
    );
}

// --- Merged from T48-KBArticle.tsx ---
// PAGE IDENTITY: T48 · KB Article Editor

export function KBArticle() {
    return (
        <PageTemplate 
            pageId="PGE-KBArticle" 
            
            sectionData={PageSectionRegistry['KBArticle']}
        />
    );
}

// --- Extracted from leads.tsx ---
// removed re-export: export { LeadsPage, LeadEntryForm, LeadConversion };


// --- Merged from F11-LeadEntry.tsx ---
// PAGE IDENTITY: F11 · Lead Entry



export function LeadEntryForm_OLD1() {
    return (
        <PageTemplate 
            pageId="PGE-LeadEntryForm_OLD1" 
            
            sectionData={PageSectionRegistry['LeadEntryForm_OLD1']}
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
        <PageTemplate 
            pageId="PGE-LeadList" 
            
            sectionData={PageSectionRegistry['LeadList']}
        />
    );
}

// --- Merged from LeadEntry.tsx ---
export function LeadEntryForm() {
    return (
        <PageTemplate 
            pageId="PGE-LeadEntryForm" 
            
            sectionData={PageSectionRegistry['LeadEntryForm']}
        />
    );
}

// --- Merged from T66-LeadConversion.tsx ---
// PAGE IDENTITY: T66 · Lead Conversion



export function LeadConversion() {
    return (
        <PageTemplate 
            pageId="PGE-LeadConversion" 
            
            sectionData={PageSectionRegistry['LeadConversion']}
        />
    );
}

// --- Extracted from locations.tsx ---
const API_URL_13 = import.meta.env.VITE_API_URL;

export function LocationForm() {
    const { showToast } = useToast();
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
        <PageTemplate 
            pageId="PGE-Locations" 
            
            sectionData={PageSectionRegistry['Locations']}
        />
    );
}

// --- Merged from list.tsx ---
export function LocationsList() {
    return (
        <PageTemplate 
            pageId="PGE-LocationsList" 
            
            sectionData={PageSectionRegistry['LocationsList']}
        />
    );
}

// --- Extracted from marketplace.tsx ---
export function Marketplace() {
    return (
        <PageTemplate 
            pageId="PGE-Marketplace" 
            
            sectionData={PageSectionRegistry['Marketplace']}
        />
    );
}

// --- Extracted from notifications.tsx ---
// --- Merged from H5-NotificationsHub.tsx ---
// PAGE IDENTITY: H5 · Notifications Hub

export function NotificationsHub() {
    return (
        <PageTemplate 
            pageId="PGE-NotificationsHub" 
            
            sectionData={PageSectionRegistry['NotificationsHub']}
        />
    );
}

// --- Extracted from observability.tsx ---
export function ObservabilityDashboard() {
    return (
        <PageTemplate 
            pageId="PGE-ObservabilityDashboard" 
            isLive
            sectionData={PageSectionRegistry['ObservabilityDashboard']}
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
        <PageTemplate 
            pageId="PGE-StaffOnboarding" 
            
            sectionData={PageSectionRegistry['StaffOnboarding']}
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
            pageId="PGE-OperationsCenter" 
            actionPageId="admin.operations"
            isLive
            sectionData={PageSectionRegistry['OperationsCenter']}
        />
    );
}

// --- Merged from T67-SupplyDemand.tsx ---
// PAGE IDENTITY: T67 · Supply & Demand

export function SupplyDemand() {
    return (
        <PageTemplate 
            pageId="PGE-SupplyDemand" 
            
            sectionData={PageSectionRegistry['SupplyDemand']}
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
                    <p style={{ margin: '4px 0 0 0', color: '#94A3B8', fontSize: '0.9rem' }}>{masterEntries.length} identity codes · {Object.keys(masterOwnerStats).length} owners · {Object.keys(masterTypeStats).length} types · Every page mapped with associates</p>
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
            pageId="PGE-GridView" 
            
            sectionData={PageSectionRegistry['GridView']}
        />
    );
}

// --- Merged from IdentityMapView.tsx ---
export function IdentityMapView() {
    return (
        <PageTemplate 
            pageId="PGE-IdentityMapView" 
            
            sectionData={PageSectionRegistry['IdentityMapView']}
        />
    );
}

// --- Merged from TableView.tsx ---
export function TableView() {
    return (
        <PageTemplate 
            pageId="PGE-TableView" 
            
            sectionData={PageSectionRegistry['TableView']}
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
            pageId="PGE-TestPage" 
            
            sectionData={PageSectionRegistry['TestPage']}
        />
    );
}

// --- Extracted from payroll.tsx ---
export function PayrollHub() {
    return (
        <PageTemplate 
            pageId="PGE-PayrollHub" 
            actionPageId="admin.payroll"
            sectionData={PageSectionRegistry['PayrollHub']}
        />
    );
}

// --- Extracted from pharmacy.tsx ---
export function PharmacyHub() {
    return (
        <PageTemplate 
            pageId="PGE-PharmacyHub" 
            actionPageId="admin.pharmacy"
            sectionData={PageSectionRegistry['PharmacyHub']}
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
            pageId="PGE-RevenueCycleHub" 
            actionPageId="admin.revenue-cycle"
            sectionData={PageSectionRegistry['RevenueCycleHub']}
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
            pageId="PGE-ReferenceDataHub" 
            actionPageId="admin.reference-data"
            sectionData={PageSectionRegistry['ReferenceDataHub']}
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
        <PageTemplate 
            pageId="PGE-ReferralList" 
            
            sectionData={PageSectionRegistry['ReferralList']}
        />
    );
}

// --- Merged from R11-ReferralAnalytics.tsx ---
// PAGE IDENTITY: R11 · Referral Analytics

export function ReferralAnalytics() {
    return (
        <PageTemplate 
            pageId="PGE-ReferralAnalytics" 
            
            sectionData={PageSectionRegistry['ReferralAnalytics']}
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
        <PageTemplate 
            pageId="PGE-ReportCenter" 
            
            sectionData={PageSectionRegistry['ReportCenter']}
        />
    );
}

// --- Merged from R2-ExportPage.tsx ---
// PAGE IDENTITY: R2 · Export Page



export function ExportPage() {
    return (
        <PageTemplate 
            pageId="PGE-ExportPage" 
            
            sectionData={PageSectionRegistry['ExportPage']}
        />
    );
}

// --- Extracted from reseller.tsx ---
// --- Merged from PrivateMarketplace.tsx ---
export function PrivateMarketplace() {
    return (
        <PageTemplate 
            pageId="PGE-PrivateMarketplace" 
            
            sectionData={PageSectionRegistry['PrivateMarketplace']}
        />
    );
}

// --- Merged from ResellerDashboard.tsx ---
export function ResellerDashboard() {
    return (
        <PageTemplate 
            pageId="PGE-ResellerDashboard" 
            
            sectionData={PageSectionRegistry['ResellerDashboard']}
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
            pageId="PGE-RolesList" 
            
            sectionData={PageSectionRegistry['RolesList']}
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
        <PageTemplate 
            pageId="PGE-RoleEditor" 
            
            sectionData={PageSectionRegistry['RoleEditor']}
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
        <PageTemplate 
            pageId="PGE-Schedule" 
            
            sectionData={PageSectionRegistry['Schedule']}
        />
    );
}

// --- Extracted from search.tsx ---
// --- Merged from T1-SearchPage.tsx ---
// PAGE IDENTITY: T1 · Search Page

export function SearchPage() {
    return (
        <PageTemplate 
            pageId="PGE-SearchPage" 
            
            sectionData={PageSectionRegistry['SearchPage']}
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
            pageId="PGE-AccountingDashboard" 
            actionPageId="admin.accounting"
            sectionData={PageSectionRegistry['AccountingDashboard']}
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
            pageId="PGE-AuditTrailViewer" 
            actionPageId="admin.audit-trail"
            sectionData={PageSectionRegistry['AuditTrailViewer']}
        />
    );
}

// --- Merged from SecurityDashboard.tsx ---
export function SecurityDashboard() {
    return (
        <PageTemplate 
            pageId="PGE-SecurityDashboard" 
            
            sectionData={PageSectionRegistry['SecurityDashboard']}
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
            pageId="PGE-SecurityGovernance" 
            actionPageId="admin.security-governance"
            sectionData={PageSectionRegistry['SecurityGovernance']}
        />
    );
}

// --- Merged from T13-DeviceManagement.tsx ---
// PAGE IDENTITY: T13 · Device Management

export function DeviceManagement() {
    return (
        <PageTemplate 
            pageId="PGE-DeviceManagement" 
            
            sectionData={PageSectionRegistry['DeviceManagement']}
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
            pageId="PGE-ForensicTrails" 
            actionPageId="admin.forensic-trails"
            sectionData={PageSectionRegistry['ForensicTrails']}
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
            pageId="PGE-CorsSettings" 
            actionPageId="admin.cors-settings"
            sectionData={PageSectionRegistry['CorsSettings']}
        />
    );
}

// --- Merged from T16-IntegrityVerification.tsx ---
// PAGE IDENTITY: T16 · Integrity Verification

export function IntegrityVerification() {
    return (
        <PageTemplate 
            pageId="PGE-IntegrityVerification" 
            
            sectionData={PageSectionRegistry['IntegrityVerification']}
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
            pageId="PGE-FinancialLedger" 
            actionPageId="admin.financial-ledger"
            sectionData={PageSectionRegistry['FinancialLedger']}
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
            pageId="PGE-TaxComplianceHub" 
            actionPageId="admin.tax-compliance"
            sectionData={PageSectionRegistry['TaxComplianceHub']}
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
            pageId="PGE-PermissionGrid" 
            actionPageId="admin.permission-grid"
            sectionData={PageSectionRegistry['PermissionGrid']}
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
            pageId="PGE-SessionMonitor" 
            actionPageId="admin.session-monitor"
            isLive
            sectionData={PageSectionRegistry['SessionMonitor']}
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
            pageId="PGE-ThreatDetection" 
            actionPageId="admin.threat-detection"
            isLive
            sectionData={PageSectionRegistry['ThreatDetection']}
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
        <PageTemplate 
            pageId="PGE-Services" 
            
            sectionData={PageSectionRegistry['Services']}
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
            pageId="PGE-MultiCurrencySettings" 
            actionPageId="admin.multi-currency"
            sectionData={PageSectionRegistry['MultiCurrencySettings']}
        />
    );
}

// --- Merged from T11-Settings.tsx ---
// PAGE IDENTITY: T11 · Settings



export function Settings() {
    return (
        <PageTemplate 
            pageId="PGE-Settings" 
            
            sectionData={PageSectionRegistry['Settings']}
        />
    );
}

// --- Extracted from setup.tsx ---
// --- Merged from H19-WizardHub.tsx ---
export function WizardHub() {
    return (
        <PageTemplate 
            pageId="PGE-WizardHub" 
            
            sectionData={PageSectionRegistry['WizardHub']}
        />
    );
}

// --- Merged from T12-BusinessStatus.tsx ---
// PAGE IDENTITY: T12 · Business Status

export function BusinessStatus() {
    return (
        <PageTemplate 
            pageId="PGE-BusinessStatus" 
            
            sectionData={PageSectionRegistry['BusinessStatus']}
        />
    );
}

// --- Merged from W1-BusinessSetupWizard.tsx ---
// PAGE IDENTITY: W1 · Business Setup Wizard

export function BusinessSetupWizard() {
    return (
        <PageTemplate 
            pageId="PGE-BusinessSetupWizard" 
            
            sectionData={PageSectionRegistry['BusinessSetupWizard']}
        />
    );
}

// --- Merged from W2-StaffOnboardingWizard.tsx ---
// PAGE IDENTITY: W2 · Staff Onboarding Wizard

export function StaffOnboardingWizard() {
    return (
        <PageTemplate 
            pageId="PGE-StaffOnboardingWizard" 
            
            sectionData={PageSectionRegistry['StaffOnboardingWizard']}
        />
    );
}

// --- Merged from W3-CarePlanWizard.tsx ---
// PAGE IDENTITY: W3 · Care Plan Wizard

export function CarePlanWizard() {
    return (
        <PageTemplate 
            pageId="PGE-CarePlanWizard" 
            
            sectionData={PageSectionRegistry['CarePlanWizard']}
        />
    );
}

// --- Merged from W4-RevenueWizard.tsx ---
// PAGE IDENTITY: W4 · Revenue Wizard

export function RevenueWizard() {
    return (
        <PageTemplate 
            pageId="PGE-RevenueWizard" 
            
            sectionData={PageSectionRegistry['RevenueWizard']}
        />
    );
}

// --- Merged from W5-BusinessModelWizard.tsx ---
// PAGE IDENTITY: W5 · Business Model Wizard

export function BusinessModelWizard() {
    return (
        <PageTemplate 
            pageId="PGE-BusinessModelWizard" 
            
            sectionData={PageSectionRegistry['BusinessModelWizard']}
        />
    );
}

// --- Extracted from sovereign.tsx ---
// --- Merged from T6-SovereignWallet.tsx ---
// PAGE IDENTITY: T6 · Sovereign Wallet

export function SovereignWallet() {
    return (
        <PageTemplate 
            pageId="PGE-SovereignWallet" 
            
            sectionData={PageSectionRegistry['SovereignWallet']}
        />
    );
}

// --- Extracted from strategy.tsx ---
// --- Merged from GrowthStrategy.tsx ---
export function GrowthStrategy() {
    return (
        <PageTemplate 
            pageId="PGE-GrowthStrategy" 
            
            sectionData={PageSectionRegistry['GrowthStrategy']}
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
            
            
            actionPageId="admin.supply-chain"
            sectionData={PageSectionRegistry['L25']}
        />
    );
}

// --- Extracted from support.tsx ---
export function SupportDashboard() {
    return (
        <PageTemplate 
            pageId="PGE-SupportDashboard" 
            
            sectionData={PageSectionRegistry['SupportDashboard']}
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
            pageId="PGE-TelehealthCenter" 
            actionPageId="admin.telehealth"
            isLive
            sectionData={PageSectionRegistry['TelehealthCenter']}
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
            pageId="PGE-TemplatesList" 
            
            sectionData={PageSectionRegistry['TemplatesList']}
        />
    );
}

// --- Merged from T3-TemplateEditor.tsx ---
// PAGE IDENTITY: T3 · Template Editor



export function TemplateEditor() {
    return (
        <PageTemplate 
            pageId="PGE-TemplateEditor" 
            
            sectionData={PageSectionRegistry['TemplateEditor']}
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
        <PageTemplate 
            pageId="PGE-TimesheetAdjustment" 
            
            sectionData={PageSectionRegistry['TimesheetAdjustment']}
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
        <PageTemplate 
            pageId="PGE-Timesheets" 
            
            sectionData={PageSectionRegistry['Timesheets']}
        />
    );
}

// --- Extracted from users.tsx ---
// removed re-export: export { UserList, UserEntry };


// --- Merged from F9a-UserEntry.tsx ---
// PAGE IDENTITY: F9a · User Entry



export function UserEntry() {
    return (
        <PageTemplate 
            pageId="PGE-UserEntry" 
            
            sectionData={PageSectionRegistry['UserEntry']}
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
        <PageTemplate 
            pageId="PGE-UserList" 
            
            sectionData={PageSectionRegistry['UserList']}
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
        <PageTemplate 
            pageId="PGE-WebhookList" 
            
            sectionData={PageSectionRegistry['WebhookList']}
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
        <PageTemplate 
            pageId="PGE-WebhookDeliveries" 
            
            sectionData={PageSectionRegistry['WebhookDeliveries']}
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
        <PageTemplate 
            pageId="PGE-FinancialReconciliation" 
            
            sectionData={PageSectionRegistry['FinancialReconciliation']}
        />
    );
}

// --- Extracted from scheduleApi.ts ---
export const API_URL_22 = import.meta.env.VITE_API_URL || 'http://localhost:8787';

export interface Visit {
    id: string; requestedStartAt: string; durationMinutes: number;
    client: { fullName: string }; psw?: { fullName: string }; assignedPswId?: string;
    status: string; isSurgeActive?: boolean; surgeMultiplier?: number;
    service?: { providerRateHourly?: string | number };
}

export function getStatusColor_2(status: string): string {
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
        return { id: v.id, title: `${v.client?.fullName || 'Unknown Client'} (${v.status})`, start, end, resource: v, style: { backgroundColor: getStatusColor(v.status as any) } };
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

export const useScheduleLogic = () => {
    const { t } = useTranslation();
    const { showToast } = useToast();
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



// --- Merged from audit-logs.tsx ---




// --- Merged from dam.tsx ---

// --- Extracted from accessibility.tsx ---
// --- Merged from ScreenReaderContentEditor.tsx ---
export function ScreenReaderContentEditor() {
    return (
        <PageTemplate 
            pageId="PGE-ScreenReaderContentEditor" 
            
            sectionData={PageSectionRegistry['ScreenReaderContentEditor']}
        />
    );
}

// --- Extracted from analytics.tsx ---
// --- Merged from ApiLatencyHeatmap.tsx ---
export function ApiLatencyHeatmap() {
    return (
        <PageTemplate 
            pageId="PGE-ApiLatencyHeatmap" 
            
            sectionData={PageSectionRegistry['ApiLatencyHeatmap']}
        />
    );
}

// --- Merged from BrowserMatrixTelemetry.tsx ---
export function BrowserMatrixTelemetry() {
    return (
        <PageTemplate 
            pageId="PGE-BrowserMatrixTelemetry" 
            
            sectionData={PageSectionRegistry['BrowserMatrixTelemetry']}
        />
    );
}

// --- Merged from CoreWebVitalsTracker.tsx ---
export function CoreWebVitalsTracker() {
    return (
        <PageTemplate 
            pageId="PGE-CoreWebVitalsTracker" 
            
            sectionData={PageSectionRegistry['CoreWebVitalsTracker']}
        />
    );
}

// --- Extracted from compliance.tsx ---
// --- Merged from LegalComplianceBlockers.tsx ---
export function LegalComplianceBlockers() {
    return (
        <PageTemplate 
            pageId="PGE-LegalComplianceBlockers" 
            
            sectionData={PageSectionRegistry['LegalComplianceBlockers']}
        />
    );
}

// --- Extracted from content.tsx ---
// --- Merged from DynamicPageRouter.tsx ---
export function DynamicPageRouter() {
    return (
        <PageTemplate 
            pageId="PGE-DynamicPageRouter" 
            
            sectionData={PageSectionRegistry['DynamicPageRouter']}
        />
    );
}

// --- Merged from MicroCopyAbTesting.tsx ---
export function MicroCopyAbTesting() {
    return (
        <PageTemplate 
            pageId="PGE-MicroCopyAbTesting" 
            
            sectionData={PageSectionRegistry['MicroCopyAbTesting']}
        />
    );
}

// --- Merged from RichTextGovernance.tsx ---
export function RichTextGovernance() {
    return (
        <PageTemplate 
            pageId="PGE-RichTextGovernance" 
            
            sectionData={PageSectionRegistry['RichTextGovernance']}
        />
    );
}

// --- Extracted from design.tsx ---
// --- Merged from DynamicTokenEditor.tsx ---
export function DynamicTokenEditor() {
    return (
        <PageTemplate 
            pageId="PGE-DynamicTokenEditor" 
            
            sectionData={PageSectionRegistry['DynamicTokenEditor']}
        />
    );
}

// --- Merged from FontTypographyRegistry.tsx ---
export function FontTypographyRegistry() {
    return (
        <PageTemplate 
            pageId="PGE-FontTypographyRegistry" 
            
            sectionData={PageSectionRegistry['FontTypographyRegistry']}
        />
    );
}

// --- Extracted from governance.tsx ---
// --- Merged from AssetCostAttribution.tsx ---
export function AssetCostAttribution() {
    return (
        <PageTemplate 
            pageId="PGE-AssetCostAttribution" 
            
            sectionData={PageSectionRegistry['AssetCostAttribution']}
        />
    );
}

// --- Merged from ErrorBoundaryAggregator.tsx ---
export function ErrorBoundaryAggregator() {
    return (
        <PageTemplate 
            pageId="PGE-ErrorBoundaryAggregator" 
            
            sectionData={PageSectionRegistry['ErrorBoundaryAggregator']}
        />
    );
}

// --- Merged from ThirdPartyScriptManager.tsx ---
export function ThirdPartyScriptManager() {
    return (
        <PageTemplate 
            pageId="PGE-ThirdPartyScriptManager" 
            
            sectionData={PageSectionRegistry['ThirdPartyScriptManager']}
        />
    );
}

// --- Extracted from localization.tsx ---
// --- Merged from GlobalI18nDictionary.tsx ---
export function GlobalI18nDictionary() {
    return (
        <PageTemplate 
            pageId="PGE-GlobalI18nDictionary" 
            
            sectionData={PageSectionRegistry['GlobalI18nDictionary']}
        />
    );
}

// --- Extracted from media.tsx ---
// --- Merged from AssetExpirationManager.tsx ---
export function AssetExpirationManager() {
    return (
        <PageTemplate 
            pageId="PGE-AssetExpirationManager" 
            
            sectionData={PageSectionRegistry['AssetExpirationManager']}
        />
    );
}

// --- Merged from CentralMediaVault.tsx ---
export function CentralMediaVault() {
    return (
        <PageTemplate 
            pageId="PGE-CentralMediaVault" 
            
            sectionData={PageSectionRegistry['CentralMediaVault']}
        />
    );
}

// --- Merged from MediaUsageHeatmap.tsx ---
export function MediaUsageHeatmap() {
    return (
        <PageTemplate 
            pageId="PGE-MediaUsageHeatmap" 
            
            sectionData={PageSectionRegistry['MediaUsageHeatmap']}
        />
    );
}

// --- Merged from SecureDocumentRedactor.tsx ---
export function SecureDocumentRedactor() {
    return (
        <PageTemplate 
            pageId="PGE-SecureDocumentRedactor" 
            
            sectionData={PageSectionRegistry['SecureDocumentRedactor']}
        />
    );
}

// --- Merged from ThirdPartyCdnSync.tsx ---
export function ThirdPartyCdnSync() {
    return (
        <PageTemplate 
            pageId="PGE-ThirdPartyCdnSync" 
            
            sectionData={PageSectionRegistry['ThirdPartyCdnSync']}
        />
    );
}

// --- Extracted from security.tsx ---
// --- Merged from AssetPermissionMatrix.tsx ---
export function AssetPermissionMatrix() {
    return (
        <PageTemplate 
            pageId="PGE-AssetPermissionMatrix" 
            
            sectionData={PageSectionRegistry['AssetPermissionMatrix']}
        />
    );
}

// --- Merged from GlobalDigitalKillSwitch.tsx ---
export function GlobalDigitalKillSwitch() {
    return (
        <PageTemplate 
            pageId="PGE-GlobalDigitalKillSwitch" 
            
            sectionData={PageSectionRegistry['GlobalDigitalKillSwitch']}
        />
    );
}

// --- Extracted from templates.tsx ---
// --- Merged from NoCodeBuilderMock.tsx ---
export function NoCodeBuilderMock() {
    return (
        <PageTemplate 
            pageId="PGE-NoCodeBuilderMock" 
            
            sectionData={PageSectionRegistry['NoCodeBuilderMock']}
        />
    );
}

// --- Extracted from traffic.tsx ---
// --- Merged from AbVariantManager.tsx ---
export function AbVariantManager() {
    return (
        <PageTemplate 
            pageId="PGE-AbVariantManager" 
            
            sectionData={PageSectionRegistry['AbVariantManager']}
        />
    );
}

// --- Extracted from workflows.tsx ---
// --- Merged from ApiEndpointRegistry.tsx ---
export function ApiEndpointRegistry() {
    return (
        <PageTemplate 
            pageId="PGE-ApiEndpointRegistry" 
            
            sectionData={PageSectionRegistry['ApiEndpointRegistry']}
        />
    );
}

// --- Merged from ApiRateLimitConfig.tsx ---
export function ApiRateLimitConfig() {
    return (
        <PageTemplate 
            pageId="PGE-ApiRateLimitConfig" 
            
            sectionData={PageSectionRegistry['ApiRateLimitConfig']}
        />
    );
}

// --- Merged from ErrorPayloadInspector.tsx ---
export function ErrorPayloadInspector() {
    return (
        <PageTemplate 
            pageId="PGE-ErrorPayloadInspector" 
            
            sectionData={PageSectionRegistry['ErrorPayloadInspector']}
        />
    );
}

// --- Merged from FormSchemaFederator.tsx ---
export function FormSchemaFederator() {
    return (
        <PageTemplate 
            pageId="PGE-FormSchemaFederator" 
            
            sectionData={PageSectionRegistry['FormSchemaFederator']}
        />
    );
}

// --- Merged from VisualLogicBuilder.tsx ---
export function VisualLogicBuilder() {
    return (
        <PageTemplate 
            pageId="PGE-VisualLogicBuilder" 
            
            sectionData={PageSectionRegistry['VisualLogicBuilder']}
        />
    );
}

// --- Merged from WorkflowVersionControl.tsx ---
export function WorkflowVersionControl() {
    return (
        <PageTemplate 
            pageId="PGE-WorkflowVersionControl" 
            
            sectionData={PageSectionRegistry['WorkflowVersionControl']}
        />
    );
}



// --- Merged from dashboard.tsx ---

export function Dashboard() {
    return (
        <PageTemplate 
            pageId="PGE-Dashboard" 
            
            sectionData={PageSectionRegistry['Dashboard']}
        />
    );
}



// --- Merged from governance-hub.tsx ---

export function GovernanceHub() {
    return (
        <PageTemplate 
            pageId="PGE-GovernanceHub" 
            
            sectionData={PageSectionRegistry['GovernanceHub']}
        />
    );
}



// --- Merged from marketing.tsx ---

// --- Extracted from b2b.tsx ---
// --- Merged from B2bSlaDashboard.tsx ---
export function B2bSlaDashboard() {
    return (
        <PageTemplate 
            pageId="PGE-B2bSlaDashboard" 
            
            sectionData={PageSectionRegistry['B2bSlaDashboard']}
        />
    );
}

// --- Merged from CorporateAccountHierarchy.tsx ---
export function CorporateAccountHierarchy() {
    return (
        <PageTemplate 
            pageId="PGE-CorporateAccountHierarchy" 
            
            sectionData={PageSectionRegistry['CorporateAccountHierarchy']}
        />
    );
}

// --- Merged from DischargePlannerPortal.tsx ---
export function DischargePlannerPortal() {
    return (
        <PageTemplate 
            pageId="PGE-DischargePlannerPortal" 
            
            sectionData={PageSectionRegistry['DischargePlannerPortal']}
        />
    );
}

// --- Merged from FacilityLunchTracker.tsx ---
export function FacilityLunchTracker() {
    return (
        <PageTemplate 
            pageId="PGE-FacilityLunchTracker" 
            
            sectionData={PageSectionRegistry['FacilityLunchTracker']}
        />
    );
}

// --- Merged from PhysicianRoiTracker.tsx ---
export function PhysicianRoiTracker() {
    return (
        <PageTemplate 
            pageId="PGE-PhysicianRoiTracker" 
            
            sectionData={PageSectionRegistry['PhysicianRoiTracker']}
        />
    );
}

// --- Merged from PostDischargeSuccess.tsx ---
export function PostDischargeSuccess() {
    return (
        <PageTemplate 
            pageId="PGE-PostDischargeSuccess" 
            
            sectionData={PageSectionRegistry['PostDischargeSuccess']}
        />
    );
}

// --- Merged from ReferralSourceHeatmap.tsx ---
export function ReferralSourceHeatmap() {
    return (
        <PageTemplate 
            pageId="PGE-ReferralSourceHeatmap" 
            
            sectionData={PageSectionRegistry['ReferralSourceHeatmap']}
        />
    );
}

// --- Extracted from brand.tsx ---
// --- Merged from AutomatedReviewAsker.tsx ---
export function AutomatedReviewAsker() {
    return (
        <PageTemplate 
            pageId="PGE-AutomatedReviewAsker" 
            
            sectionData={PageSectionRegistry['AutomatedReviewAsker']}
        />
    );
}

// --- Merged from BrandAssetLibrary.tsx ---
export function BrandAssetLibrary() {
    return (
        <PageTemplate 
            pageId="PGE-BrandAssetLibrary" 
            
            sectionData={PageSectionRegistry['BrandAssetLibrary']}
        />
    );
}

// --- Merged from CompetitorKeywordHijacker.tsx ---
export function CompetitorKeywordHijacker() {
    return (
        <PageTemplate 
            pageId="PGE-CompetitorKeywordHijacker" 
            
            sectionData={PageSectionRegistry['CompetitorKeywordHijacker']}
        />
    );
}

// --- Merged from CrisisCommsTriage.tsx ---
export function CrisisCommsTriage() {
    return (
        <PageTemplate 
            pageId="PGE-CrisisCommsTriage" 
            
            sectionData={PageSectionRegistry['CrisisCommsTriage']}
        />
    );
}

// --- Merged from GoogleBusinessSync.tsx ---
export function GoogleBusinessSync() {
    return (
        <PageTemplate 
            pageId="PGE-GoogleBusinessSync" 
            
            sectionData={PageSectionRegistry['GoogleBusinessSync']}
        />
    );
}

// --- Merged from LocalSeoRankTracker.tsx ---
export function LocalSeoRankTracker() {
    return (
        <PageTemplate 
            pageId="PGE-LocalSeoRankTracker" 
            
            sectionData={PageSectionRegistry['LocalSeoRankTracker']}
        />
    );
}

// --- Merged from ReviewSentimentAnalyzer.tsx ---
export function ReviewSentimentAnalyzer() {
    return (
        <PageTemplate 
            pageId="PGE-ReviewSentimentAnalyzer" 
            
            sectionData={PageSectionRegistry['ReviewSentimentAnalyzer']}
        />
    );
}

// --- Extracted from data.tsx ---
// --- Merged from GeoFencedAdDashboard.tsx ---
export function GeoFencedAdDashboard() {
    return (
        <PageTemplate 
            pageId="PGE-GeoFencedAdDashboard" 
            
            sectionData={PageSectionRegistry['GeoFencedAdDashboard']}
        />
    );
}

// --- Extracted from pipeline.tsx ---
// --- Merged from CostOfCareCalculator.tsx ---
export function CostOfCareCalculator() {
    return (
        <PageTemplate 
            pageId="PGE-CostOfCareCalculator" 
            
            sectionData={PageSectionRegistry['CostOfCareCalculator']}
        />
    );
}

// --- Merged from LandingPageAbTester.tsx ---
export function LandingPageAbTester() {
    return (
        <PageTemplate 
            pageId="PGE-LandingPageAbTester" 
            
            sectionData={PageSectionRegistry['LandingPageAbTester']}
        />
    );
}

// --- Merged from LeadConversionFunnel.tsx ---
export function LeadConversionFunnel() {
    return (
        <PageTemplate 
            pageId="PGE-LeadConversionFunnel" 
            
            sectionData={PageSectionRegistry['LeadConversionFunnel']}
        />
    );
}

// --- Merged from LiveChatHandover.tsx ---
export function LiveChatHandover() {
    return (
        <PageTemplate 
            pageId="PGE-LiveChatHandover" 
            
            sectionData={PageSectionRegistry['LiveChatHandover']}
        />
    );
}

// --- Merged from ReferralProgramTracker.tsx ---
export function ReferralProgramTracker() {
    return (
        <PageTemplate 
            pageId="PGE-ReferralProgramTracker" 
            
            sectionData={PageSectionRegistry['ReferralProgramTracker']}
        />
    );
}

// --- Extracted from retention.tsx ---
// --- Merged from ChurnRiskPredictor.tsx ---
export function ChurnRiskPredictor() {
    return (
        <PageTemplate 
            pageId="PGE-ChurnRiskPredictor" 
            
            sectionData={PageSectionRegistry['ChurnRiskPredictor']}
        />
    );
}

// --- Merged from DripEmailSequenceBuilder.tsx ---
export function DripEmailSequenceBuilder() {
    return (
        <PageTemplate 
            pageId="PGE-DripEmailSequenceBuilder" 
            
            sectionData={PageSectionRegistry['DripEmailSequenceBuilder']}
        />
    );
}

// --- Merged from EventRegistrationBuilder.tsx ---
export function EventRegistrationBuilder() {
    return (
        <PageTemplate 
            pageId="PGE-EventRegistrationBuilder" 
            
            sectionData={PageSectionRegistry['EventRegistrationBuilder']}
        />
    );
}

// --- Merged from MarketingRevenueAttribution.tsx ---
export function MarketingRevenueAttribution() {
    return (
        <PageTemplate 
            pageId="PGE-MarketingRevenueAttribution" 
            
            sectionData={PageSectionRegistry['MarketingRevenueAttribution']}
        />
    );
}

// --- Merged from NewsletterSubscriberDb.tsx ---
export function NewsletterSubscriberDb() {
    return (
        <PageTemplate 
            pageId="PGE-NewsletterSubscriberDb" 
            
            sectionData={PageSectionRegistry['NewsletterSubscriberDb']}
        />
    );
}

// --- Merged from PromotionalDiscountEngine.tsx ---
export function PromotionalDiscountEngine() {
    return (
        <PageTemplate 
            pageId="PGE-PromotionalDiscountEngine" 
            
            sectionData={PageSectionRegistry['PromotionalDiscountEngine']}
        />
    );
}

// --- Extracted from seo.tsx ---
// --- Merged from BlogContentCalendar.tsx ---
export function BlogContentCalendar() {
    return (
        <PageTemplate 
            pageId="PGE-BlogContentCalendar" 
            
            sectionData={PageSectionRegistry['BlogContentCalendar']}
        />
    );
}

// --- Merged from CaregiverSpotlightCreator.tsx ---
export function CaregiverSpotlightCreator() {
    return (
        <PageTemplate 
            pageId="PGE-CaregiverSpotlightCreator" 
            
            sectionData={PageSectionRegistry['CaregiverSpotlightCreator']}
        />
    );
}

// --- Merged from ContentEngagementHeatmap.tsx ---
export function ContentEngagementHeatmap() {
    return (
        <PageTemplate 
            pageId="PGE-ContentEngagementHeatmap" 
            
            sectionData={PageSectionRegistry['ContentEngagementHeatmap']}
        />
    );
}

// --- Merged from KeywordCannibalizationMonitor.tsx ---
export function KeywordCannibalizationMonitor() {
    return (
        <PageTemplate 
            pageId="PGE-KeywordCannibalizationMonitor" 
            
            sectionData={PageSectionRegistry['KeywordCannibalizationMonitor']}
        />
    );
}

// --- Merged from SeoCoreWebVitals.tsx ---
export function SeoCoreWebVitals() {
    return (
        <PageTemplate 
            pageId="PGE-SeoCoreWebVitals" 
            
            sectionData={PageSectionRegistry['SeoCoreWebVitals']}
        />
    );
}

// --- Merged from TestimonialReleaseTracker.tsx ---
export function TestimonialReleaseTracker() {
    return (
        <PageTemplate 
            pageId="PGE-TestimonialReleaseTracker" 
            
            sectionData={PageSectionRegistry['TestimonialReleaseTracker']}
        />
    );
}

// --- Merged from TrafficSourceVisualizer.tsx ---
export function TrafficSourceVisualizer() {
    return (
        <PageTemplate 
            pageId="PGE-TrafficSourceVisualizer" 
            
            sectionData={PageSectionRegistry['TrafficSourceVisualizer']}
        />
    );
}

// --- Merged from UtmParameterBuilder.tsx ---
export function UtmParameterBuilder() {
    return (
        <PageTemplate 
            pageId="PGE-UtmParameterBuilder" 
            
            sectionData={PageSectionRegistry['UtmParameterBuilder']}
        />
    );
}

// --- Extracted from syndication.tsx ---
// --- Merged from SocialMediaCredentialVault.tsx ---
export function SocialMediaCredentialVault() {
    return (
        <PageTemplate 
            pageId="PGE-SocialMediaCredentialVault" 
            
            sectionData={PageSectionRegistry['SocialMediaCredentialVault']}
        />
    );
}

// --- Extracted from territory.tsx ---
// --- Merged from SalesTerritoryMap.tsx ---
export function SalesTerritoryMap() {
    return (
        <PageTemplate 
            pageId="PGE-SalesTerritoryMap" 
            
            sectionData={PageSectionRegistry['SalesTerritoryMap']}
        />
    );
}

// --- Extracted from vaultHelpers.ts ---
export interface SocialPlatform {
    id: string; platformName: string; iconUrl: string; accountName: string | null;
    status: 'CONNECTED' | 'DISCONNECTED' | 'EXPIRED'; lastSync: string | null;
    tokenExpiry: string | null; permissions: string[];
}

export function getStatusColor(status: SocialPlatform['status']): string {
    switch(status) { case 'CONNECTED': return '#16A34A'; case 'DISCONNECTED': return '#64748B'; case 'EXPIRED': return '#DC2626'; }
}

export function getStatusBg(status: SocialPlatform['status']): string {
    switch(status) { case 'CONNECTED': return '#F0FDF4'; case 'DISCONNECTED': return '#F8FAFC'; case 'EXPIRED': return '#FEF2F2'; }
}



// --- Merged from PlatformRoutes.tsx ---


// Platform Portal (Super Admin)
const PlatformDashboard = () => <div />;
const PlatformAuditLogs = () => <div />;
const SystemPolicies = () => <div />;

export const PlatformRoutes = () => (
    <Route path={RouteRegistry.SUPERUSER.DASHBOARD} element={<RequireRole allowedRoles={['super_admin']}><AppLayout /></RequireRole>}>
        <Route index element={<PlatformDashboard />} />
        <Route path={RouteRegistry.SUPERUSER.TENANTS} element={<TenantList />} />
        <Route path={RouteRegistry.SUPERUSER.AUDIT_LOGS} element={<PlatformAuditLogs />} />
        <Route path={RouteRegistry.SUPERUSER.SLA} element={<SLAMonitoring />} />
        <Route path={RouteRegistry.SUPERUSER.RISK_SURVEILLANCE} element={<RiskSurveillanceDashboard />} />
        <Route path={RouteRegistry.SUPERUSER.GOVERNANCE_HUB} element={<GovernanceHub />} />
            <Route path={RouteRegistry.SUPERUSER.SYSTEM_POLICIES} element={<SystemPolicies />} />
    </Route>
);



// --- Merged from policies.tsx ---

// --- Merged from SystemPolicies.tsx ---
// PAGE IDENTITY: SystemPolicies · Platform Policies
// --- Merged from scrum-master.tsx ---


// --- Extracted from assetGatherers.ts ---

export interface DigitalAsset {
    name: string;
    type: 'route' | 'api' | 'button' | 'content' | 'theme' | 'click';
    section: string;
    path?: string;
    method?: string;
    detail?: string;
    visits?: number;
    lastUsed?: number;
    status: 'active' | 'unused' | 'hot';
}

const flattenObj = (obj: any, section: string, type: DigitalAsset['type'], prefix = ''): DigitalAsset[] => {
    const items: DigitalAsset[] = [];
    for (const [key, val] of Object.entries(obj)) {
        if (typeof val === 'string') {
            items.push({ name: `${prefix}${key}`.replace(/_/g, ' '), type, section, path: val, status: 'unused' });
        } else if (typeof val === 'function') {
            items.push({ name: `${prefix}${key}(...)`, type, section, path: `[dynamic]`, detail: 'parameterized', status: 'unused' });
        } else if (typeof val === 'object' && val !== null) {
            items.push(...flattenObj(val, section, type, `${key} › `));
        }
    }
    return items;
};
export const gatherApis = (): DigitalAsset[] => {
    const a: DigitalAsset[] = [];
    const sections: [string, any][] = [];
    for (const [key, val] of Object.entries(ApiRegistry)) {
        if (typeof val === 'object' && val !== null) sections.push([key, val]);
        else if (typeof val === 'string') a.push({ name: key, type: 'api', section: 'Root', path: val, status: 'unused' });
    }
    for (const [sec, obj] of sections) a.push(...flattenObj(obj, sec, 'api'));
    return a;
};

export const gatherButtons = (): DigitalAsset[] => {
    const a: DigitalAsset[] = [];
    try {
        const allButtons = (Object as any).ALL || [];
        if (Array.isArray(allButtons)) {
            for (const btn of allButtons) {
                a.push({ name: btn.label || btn.id, type: 'button', section: btn.role || btn.module || 'General', path: btn.apiPath, detail: `${btn.type || ''} · ${btn.action || ''}`, status: 'unused' });
            }
        }
        for (const [key, val] of Object.entries(Object)) {
            if (key === 'ALL') continue;
            if (typeof val === 'object' && val !== null && !Array.isArray(val)) a.push(...flattenObj(val, key, 'button'));
        }
    } catch { }
    return a;
};

export const gatherContent = (): DigitalAsset[] => {
    const a: DigitalAsset[] = [];
    try {
        for (const [key, val] of Object.entries(ContentRegistry)) {
            if (typeof val === 'string') {
                a.push({ name: key.replace(/_/g, ' '), type: 'content', section: 'Content', path: undefined, detail: String(val).slice(0, 60), status: 'active' });
            } else if (typeof val === 'object' && val !== null) {
                a.push(...flattenObj(val, key, 'content'));
            }
        }
    } catch { }
    return a;
};

export const gatherTheme = (): DigitalAsset[] => {
    const a: DigitalAsset[] = [];
    try {
        for (const [key, val] of Object.entries(ThemeRegistry.COLORS)) {
            if (typeof val === 'string') {
                a.push({ name: key.replace(/_/g, ' '), type: 'theme', section: 'CSS Variables', path: val, status: 'active' });
            } else if (typeof val === 'object') {
                for (const [k2, v2] of Object.entries(val)) {
                    a.push({ name: `${key} › ${k2}`.replace(/_/g, ' '), type: 'theme', section: 'CSS Variables', path: v2 as string, status: 'active' });
                }
            }
        }
        for (const key of Object.keys(ThemeRegistry.PRESETS)) {
            a.push({ name: key.replace(/_/g, ' '), type: 'theme', section: 'Presets', status: 'active' });
        }
    } catch { }
    return a;
};

// --- Extracted from audit.tsx ---
// --- Merged from DatabaseSchemaAudit.tsx ---
export function DatabaseSchemaAudit() {
    return (
        <PageTemplate 
            pageId="PGE-DatabaseSchemaAudit" 
            
            sectionData={PageSectionRegistry['DatabaseSchemaAudit']}
        />
    );
}

// --- Merged from EnvironmentAudit.tsx ---
export function EnvironmentAudit() {
    return (
        <PageTemplate 
            pageId="PGE-EnvironmentAudit" 
            
            sectionData={PageSectionRegistry['EnvironmentAudit']}
        />
    );
}

// --- Merged from InteractionAudit.tsx ---
export function InteractionAudit() {
    return (
        <PageTemplate 
            pageId="PGE-InteractionAudit" 
            
            sectionData={PageSectionRegistry['InteractionAudit']}
        />
    );
}

// --- Merged from RegistryIntegrityCheck.tsx ---
export function RegistryIntegrityCheck() {
    return (
        <PageTemplate 
            pageId="PGE-RegistryIntegrityCheck" 
            
            sectionData={PageSectionRegistry['RegistryIntegrityCheck']}
        />
    );
}

// --- Merged from ResponseBot.tsx ---
export function ResponseBot() {
    return (
        <PageTemplate 
            pageId="PGE-ResponseBot" 
            
            sectionData={PageSectionRegistry['ResponseBot']}
        />
    );
}

// --- Merged from TechnicalAuditPortal.tsx ---
export function TechnicalAuditPortal() {
    return (
        <PageTemplate 
            pageId="PGE-TechnicalAuditPortal" 
            
            sectionData={PageSectionRegistry['TechnicalAuditPortal']}
        />
    );
}

// --- Extracted from auditHelpers.ts ---
export interface AuditPage { name: string; path: string; variable: string; category: string; isDynamic: boolean; }

export function useAuditPages() {
    return useMemo(() => {
        const list: AuditPage[] = [];
        const seenPaths = new Set<string>();
        const processRegistry = (obj: any, category: string) => {
            if (!obj || typeof obj !== 'object') return;
            Object.entries(obj).forEach(([key, value]) => {
                const varName = `${category}.${key}`;
                if (typeof value === 'string') { if (!seenPaths.has(value)) { list.push({ name: key, path: value, variable: varName, category, isDynamic: false }); seenPaths.add(value); } }
                else if (typeof value === 'function') { list.push({ name: key, path: '(Dynamic Path Configuration)', variable: varName, category, isDynamic: true }); }
                else if (typeof value === 'object' && value !== null && !Array.isArray(value)) { processRegistry(value, varName); }
            });
        };
        processRegistry(RouteRegistry, 'RouteRegistry');
        return list.filter(p => p.variable.split('.').length > 2);
    }, []);
}

export function useAuditStats(pages: AuditPage[], testResults: Record<number, { success: boolean; status: number; time: string }>) {
    return useMemo(() => {
        const moduleCounts: Record<string, number> = {};
        pages.forEach(p => { const mod = p.category.split('.').pop() || 'Misc'; moduleCounts[mod] = (moduleCounts[mod] || 0) + 1; });
        const chartData = Object.entries(moduleCounts).map(([name, value]) => ({ name, value }));
        return { total: pages.length, modules: Object.keys(moduleCounts).length, distribution: chartData, tested: Object.keys(testResults).length, passed: Object.values(testResults).filter(r => r.success).length };
    }, [pages, testResults]);
}

export const CORE_COMPONENTS = [
    { name: 'AppLayout', path: 'shared/components/layout/AppLayout', type: 'Layout' },
    { name: 'RequireRole', path: 'shared/rbac/RequireRole', type: 'Guard' },
    { name: 'NotificationCenter', path: 'shared/context/NotificationCenterContext', type: 'Context' },
    { name: 'CommandPalette', path: 'shared/components/CommandPaletteWrapper', type: 'UI' },
    { name: 'Sidebar', path: 'shared/components/layout/Sidebar', type: 'Layout' },
    { name: 'TopBar', path: 'shared/components/layout/TopBar', type: 'Layout' },
];

// --- Extracted from builds.tsx ---
// --- Merged from BuildHealthPage.tsx ---
export function BuildHealthPage() {
    return (
        <PageTemplate 
            pageId="PGE-BuildHealthPage" 
            
            sectionData={PageSectionRegistry['BuildHealthPage']}
        />
    );
}

// --- Extracted from dashboard.tsx ---
export function ScrumMasterDashboard() {
    return (
        <PageTemplate 
            pageId="PGE-ScrumMasterDashboard" 
            actionPageId="scrum_master.dashboard"
            sectionData={PageSectionRegistry['ScrumMasterDashboard']}
        />
    );
}

// --- Extracted from dashboardHelpers.ts ---
export const dashboardHelperStyles = `
    @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
    .sm-card {
        background: rgba(255, 255, 255, 0.7);
        backdrop-filter: blur(12px);
        border: 1px solid rgba(255, 255, 255, 0.3);
        box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.07);
        border-radius: 20px;
        padding: 2rem;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        cursor: pointer;
        display: flex;
        flex-direction: column;
        height: 100%;
    }
    .sm-card:hover { 
        transform: translateY(-8px); 
        box-shadow: 0 12px 40px 0 rgba(31, 38, 135, 0.12);
        border-color: var(--brand-200);
    }
    .btn-utility {
        padding: 12px 24px;
        border-radius: 12px;
        font-weight: 700;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        transition: all 0.2s;
    }
    .btn-utility:hover { transform: scale(1.05); }
`;

export async function handleDashboardAction(
    endpoint: string, successMsg: string,
    showToast: (msg: string, type: 'success' | 'error') => void
): Promise<void> {
    try {
        const response = await apiClient.post(endpoint, {});
        if (response.ok) { showToast(successMsg, 'success'); }
        else { showToast('API Request Failed', 'error'); }
    } catch { showToast('Unable to connect to Node endpoint', 'error'); }
}

// --- Extracted from developer-kb.tsx ---
export function DeveloperKb() {
    return (
        <PageTemplate 
            pageId="PGE-DeveloperKb" 
            
            sectionData={PageSectionRegistry['DeveloperKb']}
        />
    );
}

// --- Extracted from developer.tsx ---
export function DeveloperPortal() {
    return (
        <PageTemplate 
            pageId="PGE-DeveloperPortal" 
            
            sectionData={PageSectionRegistry['DeveloperPortal']}
        />
    );
}

// --- Extracted from e2e-runner.tsx ---
export function E2eRunner() {
    return (
        <PageTemplate 
            pageId="PGE-E2eRunner" 
            
            sectionData={PageSectionRegistry['E2eRunner']}
        />
    );
}

// --- Extracted from flows.tsx ---
// --- Merged from RoleFlowsPage.tsx ---
export function RoleFlowsPage() {
    return (
        <PageTemplate 
            pageId="PGE-RoleFlowsPage" 
            
            sectionData={PageSectionRegistry['RoleFlowsPage']}
        />
    );
}

// --- Merged from StepAuditModal.tsx ---
export function StepAuditModal() {
    return (
        <PageTemplate 
            pageId="PGE-StepAuditModal" 
            
            sectionData={PageSectionRegistry['StepAuditModal']}
        />
    );
}

// --- Extracted from impersonate.tsx ---
// --- Merged from ImpersonationTool.tsx ---
export function ImpersonationTool() {
    return (
        <PageTemplate 
            pageId="PGE-ImpersonationTool" 
            
            sectionData={PageSectionRegistry['ImpersonationTool']}
        />
    );
}

// --- Extracted from locales.tsx ---
// --- Merged from LocalizationPage.tsx ---
export function LocalizationPage() {
    return (
        <PageTemplate 
            pageId="PGE-LocalizationPage" 
            
            sectionData={PageSectionRegistry['LocalizationPage']}
        />
    );
}

// --- Extracted from monitoring.tsx ---
// --- Merged from SystemHealthMonitor.tsx ---
export function SystemHealthMonitor() {
    return (
        <PageTemplate 
            pageId="PGE-SystemHealthMonitor" 
            
            sectionData={PageSectionRegistry['SystemHealthMonitor']}
        />
    );
}

// --- Extracted from performance.tsx ---
// --- Merged from PerformancePage.tsx ---
export function PerformancePage() {
    return (
        <PageTemplate 
            pageId="PGE-PerformancePage" 
            
            sectionData={PageSectionRegistry['PerformancePage']}
        />
    );
}

// --- Extracted from pipelineConfig.tsx ---
export interface PipelineStep { id: string; label: string; description: string; icon: React.ReactNode;
    status: 'idle' | 'running' | 'success' | 'error'; logs: any[]; delayMs: number;
}

export const INITIAL_PIPELINE: PipelineStep[] = [
    { id: 'brand', label: 'Initialize Platform', description: 'Creating Master Tenant & Brand Profile', icon: <Box size={20} />, status: 'idle', logs: [], delayMs: 1200 },
    { id: 'admin', label: 'Super Admin Onboarding', description: 'Generating Root Administrator Credentials', icon: <Database size={20} />, status: 'idle', logs: [], delayMs: 800 },
    { id: 'staff', label: 'Hire Operations Team', description: 'Onboarding System Manager & Care Coordinator', icon: <UserPlus size={20} />, status: 'idle', logs: [], delayMs: 1500 },
    { id: 'provider', label: 'Onboard Healthcare Provider', description: 'Register PSW / RN profiles and set availability', icon: <FileSignature size={20} />, status: 'idle', logs: [], delayMs: 1800 },
    { id: 'client', label: 'Register Client Profile', description: 'Import Patient Medical History & Contacts', icon: <Activity size={20} />, status: 'idle', logs: [], delayMs: 1100 },
    { id: 'booking', label: 'Dispatch Care Visit', description: 'Automated Match & Shift Assignment', icon: <Send size={20} />, status: 'idle', logs: [], delayMs: 2500 },
    { id: 'evv', label: 'Field Worker EVV', description: 'Execute GPS Clock-In mapping check', icon: <MapPin size={20} />, status: 'idle', logs: [], delayMs: 1400 },
];

export function getTestData(stepId: string): any {
    const map: Record<string, any> = {
        brand: { tenantId: 'tnt_9f8a7', primaryRegion: 'us-east-1', dbAllocation: 'provisioned' },
        admin: { adminId: 'usr_root', rbacRole: 'super_admin', assignedToken: 'eyJhbGciOiJIUzI...[REDACTED]' },
        staff: { recordsCreated: 2, managerId: 'usr_mgr99', coordinatorId: 'usr_cord81' },
        provider: { providerIds: ['psw_481a', 'rn_88b1'], specialtiesMined: ['geriatric', 'wound_care'] },
        client: { patientId: 'pat_0083', tags: ['fall_risk', 'dementia'], geocode: { id: 'm1', lat: 43.6532, lng: -79.3832 } },
        booking: { shiftId: 'shf_777x', assignedTo: 'psw_481a', date: '2026-03-11', duration: '4h' },
        evv: { status: 'Verified', GPS_Lock: 'True', diffMeters: 12.4, compliance: 'Passed' },
    };
    return map[stepId] || null;
}

// --- Extracted from property.tsx ---
// --- Merged from DigitalPropertyManager.tsx ---
export function DigitalPropertyManager() {
    return (
        <PageTemplate 
            pageId="PGE-DigitalPropertyManager" 
            
            sectionData={PageSectionRegistry['DigitalPropertyManager']}
        />
    );
}

// --- Extracted from propertyStyles.ts ---
export const S_2: Record<string, React.CSSProperties> = {
    page: { padding: '0 0 60px', fontFamily: "'Inter', system-ui, -apple-system, sans-serif" },
    hero: { background: 'linear-gradient(135deg, #0c4a6e 0%, #0284c7 40%, #38bdf8 100%)', borderRadius: 16, padding: '36px 40px', marginBottom: 28, position: 'relative', overflow: 'hidden' },
    heroGlow: { position: 'absolute', top: -80, right: -40, width: 240, height: 240, background: 'radial-gradient(circle, rgba(56,189,248,0.25) 0%, transparent 70%)', borderRadius: '50%', pointerEvents: 'none' },
    heroTitle: { fontSize: 28, fontWeight: 800, color: '#fff', margin: 0, letterSpacing: -0.5, display: 'flex', alignItems: 'center', gap: 12 },
    heroSub: { fontSize: 14, color: 'rgba(255,255,255,0.7)', marginTop: 6 },
    heroIcon: { width: 40, height: 40, background: 'rgba(255,255,255,0.15)', borderRadius: 10, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 22 },
    statsRow: { display: 'grid', gridTemplateColumns: 'repeat(6, 1fr)', gap: 14, marginBottom: 24 },
    stat: { background: '#fff', borderRadius: 12, padding: '16px 20px', boxShadow: '0 1px 3px rgba(0,0,0,0.06)', cursor: 'pointer', transition: 'all 0.2s', border: '2px solid transparent' },
    statActive: { borderColor: '#0284c7', boxShadow: '0 0 0 3px rgba(2,132,199,0.15)' },
    statIcon: { fontSize: 20, marginBottom: 4 },
    statVal: { fontSize: 22, fontWeight: 800, color: '#0f172a' },
    statLabel: { fontSize: 11, fontWeight: 600, textTransform: 'uppercase' as const, letterSpacing: 0.8, color: '#94a3b8', marginTop: 2 },
    filterBar: { display: 'flex', gap: 12, marginBottom: 20, flexWrap: 'wrap' as const, alignItems: 'center' },
    search: { flex: 1, minWidth: 200, padding: '10px 16px 10px 40px', borderRadius: 10, border: '1px solid #e2e8f0', fontSize: 14, fontFamily: 'inherit', outline: 'none', background: '#fff url("data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' fill=\'none\' viewBox=\'0 0 24 24\' stroke=\'%2394a3b8\' stroke-width=\'2\'%3E%3Cpath stroke-linecap=\'round\' stroke-linejoin=\'round\' d=\'M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z\'/%3E%3C/svg%3E") 12px center/18px no-repeat' },
    select: { padding: '10px 16px', borderRadius: 10, border: '1px solid #e2e8f0', fontSize: 13, fontFamily: 'inherit', background: '#fff', color: '#475569', cursor: 'pointer' },
    chip: { padding: '6px 14px', borderRadius: 20, fontSize: 12, fontWeight: 600, cursor: 'pointer', transition: 'all 0.2s', border: '1px solid #e2e8f0', background: '#fff', color: '#64748b' },
    chipActive: { background: '#0284c7', color: '#fff', borderColor: '#0284c7' },
    card: { background: '#fff', borderRadius: 14, boxShadow: '0 1px 3px rgba(0,0,0,0.06), 0 4px 12px rgba(0,0,0,0.04)', overflow: 'hidden' },
    table: { width: '100%', borderCollapse: 'collapse' as const },
    th: { padding: '10px 16px', textAlign: 'left' as const, fontSize: 11, fontWeight: 700, textTransform: 'uppercase' as const, letterSpacing: 0.8, color: '#94a3b8', borderBottom: '1px solid #f1f5f9', position: 'sticky' as const, top: 0, background: '#fff', zIndex: 1 },
    td: { padding: '10px 16px', fontSize: 13, borderBottom: '1px solid #f8fafc', color: '#334155' },
    tdMono: { fontFamily: "'JetBrains Mono', 'Fira Code', monospace", fontSize: 12, color: '#64748b' },
    badge: { display: 'inline-flex', padding: '3px 10px', borderRadius: 16, fontSize: 11, fontWeight: 700, letterSpacing: 0.3 },
    typeBadge: { route: { bg: '#eff6ff', color: '#2563eb' }, api: { bg: '#ecfdf5', color: '#059669' }, button: { bg: '#fef3c7', color: '#d97706' }, content: { bg: '#f5f3ff', color: '#7c3aed' }, theme: { bg: '#fdf2f8', color: '#db2777' }, click: { bg: '#fff7ed', color: '#ea580c' } } as Record<string, { bg: string; color: string }>,
    statusBadge: { active: { bg: '#dcfce7', color: '#166534' }, unused: { bg: '#fef2f2', color: '#dc2626' }, hot: { bg: '#fff7ed', color: '#ea580c' } } as Record<string, { bg: string; color: string }>,
    footer: { display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '12px 20px', borderTop: '1px solid #f1f5f9', fontSize: 12, color: '#94a3b8' },
    pagination: { display: 'flex', gap: 4 },
    pageBtn: { padding: '6px 12px', borderRadius: 6, border: '1px solid #e2e8f0', background: '#fff', fontSize: 12, cursor: 'pointer', color: '#475569' },
    pageBtnActive: { background: '#0284c7', color: '#fff', borderColor: '#0284c7' },
};

export const TYPE_ICONS: Record<string, string> = { route: '🛤️', api: '🔌', button: '🔘', content: '📄', theme: '🎨', click: '👆' };
export const PAGE_SIZE = 30;

// --- Extracted from repair.tsx ---
// --- Merged from RegistryAutoRepair.tsx ---
export function RegistryAutoRepair() {
    return (
        <PageTemplate 
            pageId="PGE-RegistryAutoRepair" 
            
            sectionData={PageSectionRegistry['RegistryAutoRepair']}
        />
    );
}

// --- Extracted from resourceMapping.ts ---
export interface BlueprintPage {
    name: string;
    route: string;
    component: string;
    status: 'implemented' | 'missing';
    requirement: string;
}

export interface RoleBlueprint {
    mission: string;
    pages: BlueprintPage[];
}

export const resourceMapping: Record<string, RoleBlueprint> = {
    admin: {
        mission: 'Orchestrate global franchise network, manage master financial records, and provision system-wide security policies.',
        pages: [
            { name: 'Dashboard', route: 'ADMIN.DASHBOARD', component: 'AdminDashboard', status: 'implemented', requirement: 'High-level operational overview for executive decision making.' },
            { name: 'User Management', route: 'ADMIN.USERS', component: 'UserList', status: 'implemented', requirement: 'Provision and audit security roles for all staff across the franchise.' },
            { name: 'Schedule', route: 'ADMIN.SCHEDULE', component: 'Schedule', status: 'implemented', requirement: 'Global visibility into all service appointments for master coordination.' },
            { name: 'Earnings', route: 'ADMIN.EARNINGS', component: 'AdminEarningsPage', status: 'implemented', requirement: 'Aggregate financial tracking for franchise royalty and payout audit.' },
            { name: 'Incident Tracking', route: 'ADMIN.INCIDENTS', component: 'IncidentList', status: 'implemented', requirement: 'Document and resolve high-severity clinical or operational risks.' },
            { name: 'Leads & Admissions', route: 'ADMIN.LEADS', component: 'LeadsPage', status: 'implemented', requirement: 'Manage business development pipeline and new client conversion.' },
            { name: 'Global Search', route: 'ADMIN.SEARCH', component: 'SearchPortal', status: 'implemented', requirement: 'Instant lookup for any user, patient, or record across the entire platform.' },
            { name: 'Advanced Export', route: 'ADMIN.REPORTS.EXPORT', component: 'ReportExporter', status: 'implemented', requirement: 'Custom data extraction for external compliance and tax auditing.' },
        ]
    },
    scrum_master: {
        mission: 'Maintain platform technical integrity, optimize system performance, and audit registry consistency.',
        pages: [
            { name: 'Command Center', route: 'SCRUM_MASTER.DASHBOARD', component: 'ScrumMasterDashboard', status: 'implemented', requirement: 'Centralized technical health telemetry and autonomous alerts.' },
            { name: 'API Hub', route: 'SCRUM_MASTER.API_ENDPOINTS', component: 'ApiEndpointsHub', status: 'implemented', requirement: 'Endpoint verification and backend connectivity auditing.' },
            { name: 'Role Intelligence', route: 'SCRUM_MASTER.ROLE_FLOWS', component: 'RoleFlowsPage', status: 'implemented', requirement: 'Verify UI/RBAC mapping and implementation gap analysis.' },
            { name: 'Perf Audits', route: 'SCRUM_MASTER.PERFORMANCE', component: 'PerformancePage', status: 'implemented', requirement: 'Monitor V8 engine performance and Lighthouse core web vitals.' },
            { name: 'Security Scans', route: 'SCRUM_MASTER.SECURITY_SCANS', component: 'SecurityScansPage', status: 'implemented', requirement: 'Perform SAST/DAST audits and dependency vulnerability checks.' },
            { name: 'Theme Core', route: 'SCRUM_MASTER.THEME_CENTER', component: 'ThemeCoreCenter', status: 'implemented', requirement: 'Coordinate platform-wide design tokens and CSS variable injection.' },
            { name: 'Registry Fixer', route: 'SCRUM_MASTER.AUTO_FIX', component: 'RegistryAutoRepair', status: 'implemented', requirement: 'Automated repair of broken route/API registry mappings.' },
            { name: 'User Shadowing', route: 'SCRUM_MASTER.IMPERSONATE', component: 'ImpersonationTool', status: 'implemented', requirement: 'Technical debugging by impersonating specific user sessions.' },
        ]
    },
    manager: {
        mission: 'Oversee branch care ecosystem, optimize caregiver assignments, and ensure clinical quality compliance.',
        pages: [
            { name: 'Portfolio', route: 'MANAGER.DASHBOARD', component: 'Portfolio', status: 'implemented', requirement: 'Branch-level operational dashboard for shift and patient oversight.' },
            { name: 'Evaluations', route: 'MANAGER.EVALUATIONS', component: 'Evaluations', status: 'implemented', requirement: 'Coordinate clinical assessments and care plan milestones.' },
            { name: 'Service Review', route: 'MANAGER.SERVICE_REVIEW', component: 'ServiceReview', status: 'implemented', requirement: 'Audit service quality based on client feedback and visit logs.' },
            { name: 'Staff Performance', route: 'MANAGER.PERFORMANCE', component: 'StaffRanker', status: 'implemented', requirement: 'Identify top performers and at-risk staff based on attendance metrics.' },
            { name: 'Branch Financials', route: 'MANAGER.FINANCE', component: 'BranchP_L', status: 'implemented', requirement: 'Local profit and loss visibility for branch operational efficiency.' },
            { name: 'Payroll Audit', route: 'MANAGER.PAYROLL', component: 'PayrollVerification', status: 'implemented', requirement: 'Match visit durations with scheduled hours to finalize regional payroll.' },
        ]
    },
    staff: {
        mission: 'Execute daily intake operations, coordinate scheduling requests, and manage customer communications.',
        pages: [
            { name: 'Staff Hub', route: 'STAFF.DASHBOARD', component: 'StaffDashboard', status: 'implemented', requirement: 'Daily task list and urgent scheduling notification center.' },
            { name: 'Customers', route: 'STAFF.CUSTOMERS', component: 'CustomerList', status: 'implemented', requirement: 'Manage active customer roster and scheduling preferences.' },
            { name: 'Task Board', route: 'STAFF.TASKS', component: 'TaskGrid', status: 'implemented', requirement: 'Visual board for coordinating complex multi-step intake tasks.' },
            { name: 'Messaging', route: 'STAFF.MESSAGES', component: 'MessageCenter', status: 'implemented', requirement: 'Centralized hub for family and caregiver secure communications.' },
            { name: 'Incident Logging', route: 'STAFF.INCIDENTS', component: 'IncidentPortal', status: 'implemented', requirement: 'Intake portal for clinical or operational branch-level incidents.' },
            { name: 'Branch Compliance', route: 'STAFF.COMPLIANCE', component: 'ComplianceMonitor', status: 'implemented', requirement: 'Regional scorecard for staff credential and registry health.' },
        ]
    },
    psw: {
        mission: 'Provide high-quality clinical care, document visit outcomes, and manage personal service schedule.',
        pages: [
            { name: 'My Schedule', route: 'PSW.SCHEDULE', component: 'PswSchedule', status: 'implemented', requirement: 'Real-time view of assigned care visits and patient directions.' },
            { name: 'Open Shifts', route: 'PSW.OPEN_SHIFTS', component: 'PswOpenShifts', status: 'implemented', requirement: 'Marketplace for claiming additional service hours in the region.' },
            { name: 'My Earnings', route: 'PSW.EARNINGS', component: 'PswEarnings', status: 'implemented', requirement: 'Transparent log of completed visits and upcoming payments.' },
            { name: 'Credentials', route: 'PSW.CREDENTIALS', component: 'CredentialVault', status: 'implemented', requirement: 'Submit and renew clinical certifications (CPR, VSS, etc.).' },
            { name: 'Community', route: 'PSW.FEED', component: 'ProviderSocial', status: 'implemented', requirement: 'Peer support and regional announcements for caregivers.' },
            { name: 'Live Visit', route: 'PSW.LIVE_VISIT', component: 'LiveVisit', status: 'implemented', requirement: 'Real-time check-in/out and interactive clinical task documentation.' },
        ]
    },
    rn: {
        mission: 'Maintain clinical oversight, audit caregiver documentation, and ensure professional nursing standards are met.',
        pages: [
            { name: 'Dashboard', route: 'RN.DASHBOARD', component: 'RnDashboard', status: 'implemented', requirement: 'High-level clinical overview and urgent review alerts.' },
            { name: 'Care Plans', route: 'RN.CARE_PLANS', component: 'ClinicalCarePlans', status: 'implemented', requirement: 'Digitize and manage professional patient care protocols.' },
            { name: 'Daily Audit', route: 'RN.DAILY_AUDIT', component: 'DailyAudit', status: 'implemented', requirement: 'RN sign-off and verification of PSW daily care records.' },
            { name: 'Supervision', route: 'RN.SUPERVISION', component: 'SupervisionHub', status: 'implemented', requirement: 'Monitor caregiver quality standards and certification compliance.' },
        ]
    },
    marketing_manager: {
        mission: 'Drive branch growth, manage the intake pipeline, and optimize client acquisition strategies.',
        pages: [
            { name: 'Growth Pipeline', route: 'MANAGER.MARKETING', component: 'MarketingDashboard', status: 'implemented', requirement: 'Real-time visibility into lead conversion and campaign ROI.' },
        ]
    },
    hr_manager: {
        mission: 'Oversee regional talent acquisition, manage staff onboarding, and ensure clinical compliance.',
        pages: [
            { name: 'Talent & Compliance', route: 'MANAGER.RECRUITING', component: 'HrRecruitmentPortal', status: 'implemented', requirement: 'Manage recruitment funnel and caregiver certification health.' },
        ]
    },
    recruiting_manager: {
        mission: 'Execute the recruitment pipeline, screen candidates, and manage the interview process.',
        pages: [
            { name: 'Recruitment Hub', route: 'MANAGER.RECRUITING', component: 'HrRecruitmentPortal', status: 'implemented', requirement: 'Focus on candidate sourcing and offer management.' },
        ]
    },
    finance_manager: {
        mission: 'Maintain absolute financial integrity, oversee regional reconciliation, and manage audits.',
        pages: [
            { name: 'Finance & Governance', route: 'MANAGER.FINANCE', component: 'FinanceRegionalHub', status: 'implemented', requirement: 'Real-time revenue intelligence and expense auditing.' },
        ]
    },
    regional_manager: {
        mission: 'Audit branch-level operational performance and optimize regional profitability.',
        pages: [
            { name: 'Regional Hub', route: 'MANAGER.FINANCE', component: 'FinanceRegionalHub', status: 'implemented', requirement: 'High-level P&L visibility and benchmarking across locations.' },
        ]
    },
    clinical_manager: {
        mission: 'Maintain professional clinical safety standards, oversee medication QA, and audit high-risk incidents.',
        pages: [
            { name: 'Clinical QA', route: 'MANAGER.CLINICAL', component: 'ClinicalQaDashboard', status: 'implemented', requirement: 'Real-time safety alerts and medication compliance oversight.' },
        ]
    },
    client: {
        mission: 'Manage family care plans, request service adjustments, and oversee billing and invoices.',
        pages: [
            { name: 'Client Hub', route: 'CLIENT.DASHBOARD', component: 'ClientDashboard', status: 'implemented', requirement: 'Family overview for current care schedule and caregiver intros.' },
            { name: 'Bookings', route: 'CLIENT.BOOKINGS', component: 'ClientBookings', status: 'implemented', requirement: 'History of previous visits and upcoming scheduled care.' },
            { name: 'Billing', route: 'CLIENT.BILLING', component: 'ClientBilling', status: 'implemented', requirement: 'Secure payment gateway and digital invoice archive.' },
            { name: 'Service Catalog', route: 'CLIENT.SERVICES', component: 'CatalogBrowser', status: 'implemented', requirement: 'Self-service selection of additional specialized care modules.' },
            { name: 'Care Chat', route: 'CLIENT.SUPPORT', component: 'ClientMessaging', status: 'implemented', requirement: 'Direct secure line to nursing staff for care concerns.' },
            { name: 'Care Team', route: 'CLIENT.TEAM', component: 'CareTeam', status: 'implemented', requirement: 'View assigned caregiver profiles, specialties, and ratings.' },
            { name: 'Feedback Loop', route: 'CLIENT.FEEDBACK_LOOP', component: 'FeedbackLoop', status: 'implemented', requirement: 'Submit satisfaction reviews and clinical comments for recent visits.' },
        ]
    }
};

// --- Extracted from roleFlowsData.ts ---
export interface RoleFlowEntry {
    label: string;
    steps: readonly string[];
    color: string;
    icon: string;
}

export function buildRoleFlows(t: (key: string) => string): Record<string, RoleFlowEntry> {
    return {
        admin: {
            label: t(ContentRegistry.ROLE_LABELS.ADMIN),
            icon: '👑',
            color: 'var(--brand-500)',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.ADMIN,
        },
        scrum_master: {
            label: t(ContentRegistry.ROLE_LABELS.SCRUM_MASTER),
            icon: '🚀',
            color: '#8b5cf6',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.SCRUM_MASTER,
        },
        manager: {
            label: t(ContentRegistry.ROLE_LABELS.MANAGER),
            icon: '🏢',
            color: '#3b82f6',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.MANAGER,
        },
        staff: {
            label: t(ContentRegistry.ROLE_LABELS.STAFF),
            icon: '👤',
            color: '#10b981',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.STAFF,
        },
        psw: {
            label: t(ContentRegistry.ROLE_LABELS.PSW),
            icon: '🩺',
            color: '#f59e0b',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.PSW,
        },
        rn: {
            label: t(ContentRegistry.ROLE_LABELS.RN),
            icon: '🩺',
            color: '#06b6d4',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.RN,
        },
        marketing_manager: {
            label: 'Marketing Manager',
            icon: '📈',
            color: '#ec4899',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.MARKETING_MANAGER,
        },
        hr_manager: {
            label: 'HR Manager',
            icon: '👤',
            color: '#8b5cf6',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.HR_MANAGER,
        },
        recruiting_manager: {
            label: 'Recruiting Manager',
            icon: '🤝',
            color: '#6366f1',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.RECRUITING_MANAGER,
        },
        finance_manager: {
            label: 'Finance Manager',
            icon: '💰',
            color: '#0ea5e9',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.FINANCE_MANAGER,
        },
        regional_manager: {
            label: 'Regional Manager',
            icon: '🏢',
            color: '#0f172a',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.REGIONAL_MANAGER,
        },
        clinical_manager: {
            label: 'Clinical Manager',
            icon: '🩺',
            color: '#e11d48',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.CLINICAL_MANAGER,
        },
        coordinator: {
            label: 'Coordinator',
            icon: '📡',
            color: '#06b6d4',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.COORDINATOR,
        },
        client: {
            label: t(ContentRegistry.ROLE_LABELS.CLIENT),
            icon: '🏠',
            color: '#ec4899',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.CLIENT,
        },
    };
}

// --- Extracted from roleFlowsStyles.ts ---
export const roleFlowsStyles = `
    @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
    .bento-grid {
        display: grid;
        grid-template-columns: repeat(12, 1fr);
        gap: 1.5rem;
    }
    .bento-item {
        background: rgba(255, 255, 255, 0.8);
        backdrop-filter: blur(12px);
        border: 1px solid rgba(255, 255, 255, 0.3);
        border-radius: 20px;
        padding: 1.5rem;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.05);
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }
    .bento-item:hover { transform: translateY(-4px); box-shadow: 0 12px 48px rgba(0, 0, 0, 0.08); }
    .role-select-item {
        padding: 10px 16px;
        border-radius: 12px;
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 10px;
        transition: all 0.2s;
        border: 1px solid transparent;
        background: var(--bg-100);
        font-weight: 600;
    }
    .role-select-item.active {
        background: white;
        border-color: var(--brand-500);
        box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    }
    .step-card {
        padding: 1.5rem;
        background: white;
        border-radius: 16px;
        border: 1px solid #f1f5f9;
        transition: all 0.2s;
        display: flex;
        gap: 1.5rem;
        align-items: flex-start;
        cursor: pointer;
    }
    .step-card:hover { border-color: var(--brand-500); background: #f8fafc; }
    .blueprint-table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0 8px;
    }
    .blueprint-table th {
        text-align: left;
        padding: 12px 16px;
        color: var(--text-400);
        font-size: 0.7rem;
        text-transform: uppercase;
        font-weight: 800;
    }
    .blueprint-table td {
        padding: 16px;
        background: white;
        border-top: 1px solid #f1f5f9;
        border-bottom: 1px solid #f1f5f9;
        font-family: 'Inter', sans-serif;
    }
    .blueprint-table tr td:first-child { border-left: 1px solid #f1f5f9; border-top-left-radius: 12px; border-bottom-left-radius: 12px; }
    .blueprint-table tr td:last-child { border-right: 1px solid #f1f5f9; border-top-right-radius: 12px; border-bottom-right-radius: 12px; }
    .status-badge {
        padding: 4px 10px;
        border-radius: 6px;
        font-size: 0.65rem;
        font-weight: 800;
        text-transform: uppercase;
    }
    .status-implemented { background: rgba(16, 185, 129, 0.1); color: #10b981; }
    .status-missing { background: rgba(239, 68, 68, 0.1); color: #ef4444; }
`;

// --- Extracted from scans.tsx ---
// --- Merged from SecurityScansPage.tsx ---
export function SecurityScansPage() {
    return (
        <PageTemplate 
            pageId="PGE-SecurityScansPage" 
            
            sectionData={PageSectionRegistry['SecurityScansPage']}
        />
    );
}

// --- Extracted from ScrumMasterRoutes.tsx ---
// Scrum Master Pages
// --- Extracted from testing.tsx ---
// --- Merged from ApiEndpointsHub.tsx ---
export function ApiEndpointsHub() {
    return (
        <PageTemplate 
            pageId="PGE-ApiEndpointsHub" 
            
            sectionData={PageSectionRegistry['ApiEndpointsHub']}
        />
    );
}

// --- Extracted from theme.tsx ---
// --- Merged from ThemeCoreCenter.tsx ---
export function ThemeCoreCenter() {
    return (
        <PageTemplate 
            pageId="PGE-ThemeCoreCenter" 
            
            sectionData={PageSectionRegistry['ThemeCoreCenter']}
        />
    );
}

// --- Extracted from themeConfig.ts ---
/* ─────────── Registry-Driven Color Map ─────────── */
export const REGISTRY_COLORS = [
    { key: 'primary', label: 'Primary', variable: ThemeRegistry.COLORS.PRIMARY, group: 'brand' as const },
    { key: 'primaryDark', label: 'Primary Dark', variable: ThemeRegistry.COLORS.PRIMARY_DARK, group: 'brand' as const },
    { key: 'accent', label: 'Accent', variable: ThemeRegistry.COLORS.ACCENT, group: 'brand' as const },
    { key: 'background', label: 'Background', variable: ThemeRegistry.COLORS.BACKGROUND, group: 'surface' as const },
    { key: 'surface', label: 'Surface', variable: ThemeRegistry.COLORS.SURFACE, group: 'surface' as const },
] as const;

export const DEFAULT_PRESET = 'PRIMECARE_STANDARD';
const defaultPreset = ThemeRegistry.PRESETS[DEFAULT_PRESET];

export const INITIAL_COLORS: Record<string, string> = {
    primary: defaultPreset.primary,
    primaryDark: defaultPreset.primaryDark,
    accent: defaultPreset.accent,
    background: '#f9fafb',
    surface: '#ffffff',
};

export const buildGradient = (p: typeof ThemeRegistry.PRESETS[keyof typeof ThemeRegistry.PRESETS]) =>
    `linear-gradient(135deg, ${p.primaryDark}, ${p.primary}, ${p.accent})`;

export const PRESET_LABELS: Record<string, string> = {
    PRIMECARE_STANDARD: 'PrimeCare Standard',
    DUSK_MODE: 'Dusk Mode',
    EMERALD_CITY: 'Emerald City',
};

/* ─────────────────── Styles ─────────────────── */
export const S_3: Record<string, React.CSSProperties> = {
    page: { padding: '0 0 60px', fontFamily: "'Inter', system-ui, -apple-system, sans-serif" },
    hero: { background: 'linear-gradient(135deg, #0f172a 0%, #1e3a5f 50%, #0ea5e9 100%)', borderRadius: 16, padding: '36px 40px', marginBottom: 32, position: 'relative', overflow: 'hidden' },
    heroGlow: { position: 'absolute', top: -60, right: -60, width: 200, height: 200, background: 'radial-gradient(circle, rgba(56,189,248,0.25) 0%, transparent 70%)', borderRadius: '50%', pointerEvents: 'none' },
    heroTitle: { fontSize: 28, fontWeight: 800, color: '#fff', margin: 0, letterSpacing: -0.5, display: 'flex', alignItems: 'center', gap: 12 },
    heroSub: { fontSize: 14, color: 'rgba(255,255,255,0.7)', marginTop: 6 },
    heroIcon: { width: 36, height: 36, background: 'rgba(255,255,255,0.15)', borderRadius: 10, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 20 },
    card: { background: '#fff', borderRadius: 14, boxShadow: '0 1px 3px rgba(0,0,0,0.06), 0 4px 12px rgba(0,0,0,0.04)', overflow: 'hidden' },
    cardH: { padding: '16px 20px', fontWeight: 700, fontSize: 14, textTransform: 'uppercase' as const, letterSpacing: 0.8, color: '#475569', borderBottom: '1px solid #f1f5f9', display: 'flex', alignItems: 'center', gap: 8 },
    grid3: { display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: 16, marginBottom: 28 },
    grid2: { display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 24, marginBottom: 28 },
    grid3preview: { display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: 20 },
    preset: { borderRadius: 14, padding: 0, cursor: 'pointer', border: '2px solid transparent', transition: 'all 0.25s ease', position: 'relative' as const, overflow: 'hidden', background: 'none' },
    presetActive: { border: '2px solid #3b82f6', boxShadow: '0 0 0 3px rgba(59,130,246,0.2)' },
    presetGradient: { height: 100, borderRadius: '12px 12px 0 0', position: 'relative' as const },
    presetInfo: { padding: '12px 16px', background: '#fff', borderRadius: '0 0 12px 12px' },
    presetName: { fontSize: 13, fontWeight: 700, color: '#1e293b', textAlign: 'left' as const },
    presetDots: { display: 'flex', gap: 6, marginTop: 6 },
    presetDot: { width: 16, height: 16, borderRadius: '50%', border: '2px solid rgba(255,255,255,0.3)' },
    presetCheck: { position: 'absolute' as const, top: 8, right: 8, width: 24, height: 24, borderRadius: '50%', background: '#3b82f6', display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#fff', fontSize: 14, fontWeight: 700, boxShadow: '0 2px 6px rgba(59,130,246,0.4)' },
    colorGroup: { marginBottom: 20 },
    colorGroupLabel: { fontSize: 11, fontWeight: 700, textTransform: 'uppercase' as const, color: '#94a3b8', letterSpacing: 1.2, marginBottom: 12 },
    colorRow: { display: 'flex', alignItems: 'center', gap: 14, padding: '10px 0', borderBottom: '1px solid #f8fafc' },
    colorSwatch: { width: 40, height: 40, borderRadius: '50%', border: '3px solid #fff', boxShadow: '0 2px 8px rgba(0,0,0,0.12)', cursor: 'pointer', flexShrink: 0, position: 'relative' as const },
    colorHiddenInput: { position: 'absolute' as const, opacity: 0, width: '100%', height: '100%', cursor: 'pointer', top: 0, left: 0 },
    colorLabel: { flex: 1, fontSize: 13, fontWeight: 600, color: '#334155' },
    colorVar: { fontSize: 11, fontWeight: 500, color: '#94a3b8', fontFamily: "'JetBrains Mono', 'Fira Code', monospace" },
    colorHex: { width: 90, padding: '6px 10px', borderRadius: 8, border: '1px solid #e2e8f0', fontFamily: "'JetBrains Mono', 'Fira Code', monospace", fontSize: 12, color: '#475569', textAlign: 'center' as const, background: '#f8fafc' },
    codeCard: { background: '#0f172a', borderRadius: 14, overflow: 'hidden' },
    codeHeader: { padding: '12px 20px', display: 'flex', justifyContent: 'space-between', alignItems: 'center', borderBottom: '1px solid #1e293b' },
    codeTitle: { fontSize: 12, fontWeight: 700, color: '#64748b', textTransform: 'uppercase' as const, letterSpacing: 1 },
    codeCopy: { padding: '4px 12px', borderRadius: 6, border: '1px solid #334155', background: 'transparent', color: '#94a3b8', fontSize: 11, cursor: 'pointer', transition: 'all 0.2s' },
    codeBody: { padding: '16px 20px', fontFamily: "'JetBrains Mono', 'Fira Code', monospace", fontSize: 13, lineHeight: 1.8 },
    codeBrace: { color: '#f8fafc' },
    codeProp: { color: '#7dd3fc' },
    codeVal: { color: '#a5f3fc' },
    previewBox: { padding: 24, borderRadius: 12, background: '#f8fafc', border: '1px solid #e2e8f0' },
    previewTitle: { fontSize: 12, fontWeight: 700, textTransform: 'uppercase' as const, color: '#94a3b8', marginBottom: 16, letterSpacing: 0.8 },
    btnPrimary: { padding: '10px 24px', borderRadius: 10, border: 'none', fontWeight: 700, fontSize: 13, cursor: 'pointer', transition: 'all 0.2s', color: '#fff', boxShadow: '0 2px 8px rgba(0,0,0,0.15)' },
    btnSecondary: { padding: '10px 24px', borderRadius: 10, fontWeight: 700, fontSize: 13, cursor: 'pointer', transition: 'all 0.2s', background: 'transparent' },
    btnGhost: { padding: '10px 24px', borderRadius: 10, border: '1px solid #e2e8f0', background: 'transparent', fontWeight: 600, fontSize: 13, cursor: 'pointer', color: '#64748b' },
    alertSuccess: { padding: '14px 18px', borderRadius: 10, display: 'flex', alignItems: 'center', gap: 10, fontSize: 13, fontWeight: 500 },
    alertWarning: { padding: '14px 18px', borderRadius: 10, display: 'flex', alignItems: 'center', gap: 10, background: '#fffbeb', border: '1px solid #fde68a', color: '#92400e', fontSize: 13, fontWeight: 500 },
    statCard: { padding: 20, borderRadius: 12, background: '#fff', boxShadow: '0 1px 3px rgba(0,0,0,0.08)' },
    statLabel: { fontSize: 11, fontWeight: 700, textTransform: 'uppercase' as const, letterSpacing: 0.8 },
    statValue: { fontSize: 28, fontWeight: 800, marginTop: 4, color: '#0f172a' },
    statDelta: { fontSize: 12, fontWeight: 600, marginTop: 4 },
    badge: { display: 'inline-flex', padding: '4px 14px', borderRadius: 20, fontSize: 12, fontWeight: 700, letterSpacing: 0.3 },
    progressTrack: { height: 8, borderRadius: 4, background: '#e2e8f0', overflow: 'hidden' },
    progressFill: { height: '100%', borderRadius: 4, transition: 'width 0.5s ease' },
    typoH1: { fontSize: 24, fontWeight: 800, color: '#0f172a', margin: '0 0 6px' },
    typoP: { fontSize: 14, color: '#64748b', lineHeight: 1.6, margin: 0 },
    saveBar: { display: 'flex', justifyContent: 'flex-end', gap: 12, marginBottom: 28 },
    saveBtn: { padding: '10px 28px', borderRadius: 10, border: 'none', fontWeight: 700, fontSize: 14, cursor: 'pointer', background: '#3b82f6', color: '#fff', boxShadow: '0 2px 10px rgba(59,130,246,0.3)', transition: 'all 0.2s' },
    saveBtnDisabled: { opacity: 0.5, cursor: 'not-allowed' },
    resetBtn: { padding: '10px 28px', borderRadius: 10, border: '1px solid #e2e8f0', background: '#fff', fontWeight: 600, fontSize: 14, cursor: 'pointer', color: '#64748b' },
    statusBadge: { display: 'inline-flex', alignItems: 'center', gap: 6, padding: '6px 16px', borderRadius: 20, fontSize: 12, fontWeight: 600 },
};

// --- Extracted from usage.tsx ---
// --- Merged from UsageStatisticsManager.tsx ---
export function UsageStatisticsManager() {
    return (
        <PageTemplate 
            pageId="PGE-UsageStatisticsManager" 
            
            sectionData={PageSectionRegistry['UsageStatisticsManager']}
        />
    );
}

// --- Extracted from usageConfig.ts ---
// usageConfig starts
export const formatTime = (ms: number) => {
    if (ms < 1000) return `${ms}ms`;
    if (ms < 60000) return `${(ms / 1000).toFixed(1)}s`;
    if (ms < 3600000) return `${(ms / 60000).toFixed(1)}m`;
    return `${(ms / 3600000).toFixed(1)}h`;
};

export const timeAgo = (ts: number) => {
    if (!ts) return 'Never';
    const d = Date.now() - ts;
    if (d < 60000) return 'Just now';
    if (d < 3600000) return `${Math.floor(d / 60000)}m ago`;
    if (d < 86400000) return `${Math.floor(d / 3600000)}h ago`;
    return `${Math.floor(d / 86400000)}d ago`;
};

export const getUsageLevel = (count: number, max: number) => {
    if (count === 0) return { label: 'Unused', color: '#ef4444', bg: '#fef2f2' };
    const ratio = count / (max || 1);
    if (ratio > 0.6) return { label: 'Hot', color: '#f97316', bg: '#fff7ed' };
    if (ratio > 0.3) return { label: 'Active', color: '#22c55e', bg: '#f0fdf4' };
    return { label: 'Low', color: '#eab308', bg: '#fefce8' };
};

/* ─── All known platform routes ─── */
/* ─── Styles ─── */
export const S_5: Record<string, React.CSSProperties> = {
    page: { padding: '0 0 60px', fontFamily: "'Inter', system-ui, -apple-system, sans-serif" },
    hero: { background: 'linear-gradient(135deg, #312e81 0%, #4338ca 50%, #818cf8 100%)', borderRadius: 16, padding: '36px 40px', marginBottom: 32, position: 'relative', overflow: 'hidden' },
    heroGlow: { position: 'absolute', top: -80, right: -40, width: 220, height: 220, background: 'radial-gradient(circle, rgba(165,180,252,0.3) 0%, transparent 70%)', borderRadius: '50%', pointerEvents: 'none' },
    heroTitle: { fontSize: 28, fontWeight: 800, color: '#fff', margin: 0, letterSpacing: -0.5, display: 'flex', alignItems: 'center', gap: 12 },
    heroSub: { fontSize: 14, color: 'rgba(255,255,255,0.7)', marginTop: 6 },
    heroIcon: { width: 36, height: 36, background: 'rgba(255,255,255,0.15)', borderRadius: 10, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 20 },
    topBar: { display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 24, flexWrap: 'wrap' as const, gap: 12 },
    statRow: { display: 'grid', gridTemplateColumns: 'repeat(5, 1fr)', gap: 16, marginBottom: 28 },
    stat: { background: '#fff', borderRadius: 14, padding: '20px 24px', boxShadow: '0 1px 3px rgba(0,0,0,0.06), 0 4px 12px rgba(0,0,0,0.04)' },
    statLabel: { fontSize: 11, fontWeight: 700, textTransform: 'uppercase' as const, letterSpacing: 0.8, color: '#94a3b8', marginBottom: 4 },
    statVal: { fontSize: 28, fontWeight: 800, color: '#0f172a' },
    statNote: { fontSize: 12, color: '#94a3b8', marginTop: 4 },
    card: { background: '#fff', borderRadius: 14, boxShadow: '0 1px 3px rgba(0,0,0,0.06), 0 4px 12px rgba(0,0,0,0.04)', overflow: 'hidden', marginBottom: 28 },
    cardH: { padding: '16px 20px', fontWeight: 700, fontSize: 14, textTransform: 'uppercase' as const, letterSpacing: 0.8, color: '#475569', borderBottom: '1px solid #f1f5f9', display: 'flex', alignItems: 'center', justifyContent: 'space-between' },
    table: { width: '100%', borderCollapse: 'collapse' as const },
    th: { padding: '10px 16px', textAlign: 'left' as const, fontSize: 11, fontWeight: 700, textTransform: 'uppercase' as const, letterSpacing: 0.8, color: '#94a3b8', borderBottom: '1px solid #f1f5f9' },
    td: { padding: '12px 16px', fontSize: 13, borderBottom: '1px solid #f8fafc', color: '#334155' },
    tdMono: { fontFamily: "'JetBrains Mono', 'Fira Code', monospace", fontSize: 12 },
    badge: { display: 'inline-flex', padding: '3px 10px', borderRadius: 16, fontSize: 11, fontWeight: 700, letterSpacing: 0.3 },
    heatBar: { height: 6, borderRadius: 3, background: '#e2e8f0', overflow: 'hidden', width: 80, display: 'inline-block', verticalAlign: 'middle', marginLeft: 8 },
    heatFill: { height: '100%', borderRadius: 3, transition: 'width 0.4s ease' },
    tabRow: { display: 'flex', gap: 4, flexWrap: 'wrap' as const },
    tab: { padding: '8px 16px', borderRadius: 10, border: '1px solid #e2e8f0', background: '#fff', cursor: 'pointer', fontSize: 13, fontWeight: 600, color: '#64748b', transition: 'all 0.2s' },
    tabActive: { background: '#4338ca', color: '#fff', borderColor: '#4338ca' },
    resetBtn: { padding: '8px 20px', borderRadius: 8, border: '1px solid #fee2e2', background: '#fff', color: '#ef4444', fontSize: 12, fontWeight: 600, cursor: 'pointer' },
    refreshBtn: { padding: '8px 20px', borderRadius: 8, border: '1px solid #e2e8f0', background: '#fff', color: '#475569', fontSize: 12, fontWeight: 600, cursor: 'pointer' },
    emptyState: { padding: 40, textAlign: 'center' as const, color: '#94a3b8' },
    scrollBar: { height: 6, borderRadius: 3, background: '#e2e8f0', overflow: 'hidden', width: 60 },
    scrollFill: { height: '100%', borderRadius: 3, background: 'linear-gradient(90deg, #818cf8, #4338ca)' },
};

export type TabKey = 'routes' | 'clicks' | 'forms' | 'api' | 'unused';



// --- Merged from sla-monitoring.tsx ---

export function SLAMonitoring() {
    return (
        <PageTemplate 
            pageId="PGE-SLAMonitoring" 
            
            sectionData={PageSectionRegistry['SLAMonitoring']}
        />
    );
}



// --- Merged from superuser.tsx ---


// --- Merged from RiskSurveillanceDashboard.tsx ---
export function RiskSurveillanceDashboard() {
    return (
        <PageTemplate 
            pageId="PGE-RiskSurveillanceDashboard" 
            
            sectionData={PageSectionRegistry['RiskSurveillanceDashboard']}
        />
    );
}


export function SuperAdminDashboard() {
    return (
        <PageTemplate 
            pageId="PGE-SuperAdminDashboard" 
            
            sectionData={PageSectionRegistry['SuperAdminDashboard']}
        />
    );
}



// --- Merged from tenants.tsx ---

export function TenantList() {
    return (
        <PageTemplate 
            pageId="PGE-TenantList" 
            
            sectionData={PageSectionRegistry['TenantList']}
        />
    );
}

