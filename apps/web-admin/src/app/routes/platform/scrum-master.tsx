const { RouteRegistry, ApiRegistry, ContentRegistry, ThemeRegistry, PageRegistry, FormRegistry } = AdminRegistry;

import { PageSectionRegistry } from "@/shared/PageSectionRegistry";
import AppLayout from "@/shared/components/layout/AppLayout";
import { PageTemplate } from "@/shared/components/ui/PageTemplate";
import RequireRole from "@/shared/rbac/RequireRole";
import { apiClient } from "@/shared/utils/apiClient";
import { Box, Database, UserPlus, FileSignature, Activity, Send, MapPin } from "lucide-react";
import { AdminRegistry } from "prime-care-shared";
import React, { useMemo, lazy } from "react";
import { Route } from "react-router";

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
            pageId="PGE-DSA" 
            title="✨ Database Schema Audit" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-DSA']}
        />
    );
}

// --- Merged from EnvironmentAudit.tsx ---
export function EnvironmentAudit() {
    return (
        <PageTemplate 
            pageId="PGE-EA" 
            title="✨ Environment Audit" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-EA']}
        />
    );
}

// --- Merged from InteractionAudit.tsx ---
export function InteractionAudit() {
    return (
        <PageTemplate 
            pageId="PG-207" 
            title="RESPONSE BOT" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-207']}
        />
    );
}

// --- Merged from RegistryIntegrityCheck.tsx ---
export function RegistryIntegrityCheck() {
    return (
        <PageTemplate 
            pageId="PGE-RIC" 
            title="✨ Registry Integrity Check" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-RIC']}
        />
    );
}

// --- Merged from ResponseBot.tsx ---
export function ResponseBot() {
    return (
        <PageTemplate 
            pageId="PGE-RB" 
            title="✨ Response Bot" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-RB']}
        />
    );
}

// --- Merged from TechnicalAuditPortal.tsx ---
export function TechnicalAuditPortal() {
    return (
        <PageTemplate 
            pageId="PGE-TAP" 
            title="✨ Technical Audit Portal" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-TAP']}
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
            pageId="PG-610" 
            title="Build & Deployment Health" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-610']}
        />
    );
}

// --- Extracted from dashboard.tsx ---
export function ScrumMasterDashboard() {
    return (
        <PageTemplate pageId="SM" title="Command Center" subtitle="Scrum Master Command Center"
            actionPageId="scrum_master.dashboard"
            sectionData={PageSectionRegistry['SM']}
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
            pageId="PG-880" 
            title="Implementation Specs: {selectedRole.toUpperCase()}" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-880']}
        />
    );
}

// --- Extracted from developer.tsx ---
export function DeveloperPortal() {
    return (
        <PageTemplate 
            pageId="PG-695" 
            title="Developer Portal" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-695']}
        />
    );
}

// --- Extracted from e2e-runner.tsx ---
export function E2eRunner() {
    return (
        <PageTemplate 
            pageId="PG-205" 
            title="E2eRunner" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-205']}
        />
    );
}

// --- Extracted from flows.tsx ---
// --- Merged from RoleFlowsPage.tsx ---
export function RoleFlowsPage() {
    return (
        <PageTemplate 
            pageId="PGE-RFP" 
            title="✨ Role Flows Page" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-RFP']}
        />
    );
}

// --- Merged from StepAuditModal.tsx ---
export function StepAuditModal() {
    return (
        <PageTemplate 
            pageId="PGE-SAM" 
            title="✨ Step Audit Modal" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-SAM']}
        />
    );
}

// --- Extracted from impersonate.tsx ---
// --- Merged from ImpersonationTool.tsx ---
export function ImpersonationTool() {
    return (
        <PageTemplate 
            pageId="PGE-IT" 
            title="✨ Impersonation Tool" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-IT']}
        />
    );
}

// --- Extracted from locales.tsx ---
// --- Merged from LocalizationPage.tsx ---
export function LocalizationPage() {
    return (
        <PageTemplate 
            pageId="PG-233" 
            title="Localization Health" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-233']}
        />
    );
}

// --- Extracted from monitoring.tsx ---
// --- Merged from SystemHealthMonitor.tsx ---
export function SystemHealthMonitor() {
    return (
        <PageTemplate 
            pageId="PGE-SHM" 
            title="✨ System Health Monitor" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-SHM']}
        />
    );
}

// --- Extracted from performance.tsx ---
// --- Merged from PerformancePage.tsx ---
export function PerformancePage() {
    return (
        <PageTemplate 
            pageId="PG-128" 
            title="Performance Orchestration" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-128']}
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
            pageId="PG-454" 
            title="🏛️ Digital Property Manager" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-454']}
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
            pageId="PGE-RAR" 
            title="✨ Registry Auto Repair" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-RAR']}
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
            pageId="PG-738" 
            title="Security & Vulnerability Scans" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-738']}
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
            pageId="PGE-AEH" 
            title="✨ Api Endpoints Hub" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-AEH']}
        />
    );
}

// --- Extracted from theme.tsx ---
// --- Merged from ThemeCoreCenter.tsx ---
export function ThemeCoreCenter() {
    return (
        <PageTemplate 
            pageId="PG-423" 
            title="🎨Theme Core Center" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-423']}
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
            pageId="PG-128" 
            title="📊 Usage Statistics Manager" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-128']}
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
