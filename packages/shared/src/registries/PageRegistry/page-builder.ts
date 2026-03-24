import type { PageEntry, PageType } from '../PageRegistry';
import { CATEGORY_PREFIXES } from '../PageRegistry';
import { DashboardRegistry } from './homes';
import { ListRegistry } from './lists';
import { HubRegistry } from './hubs';
import { WizardRegistry, ReportRegistry } from './wizards-reports';
import { ToolRegistry } from './tools';

// ── Raw Page Type (before serial numbering) ──────────────────────────────────

type RawPage = Omit<PageEntry, 'srNo' | 'categoryCode'>;

// ── Static Pages ─────────────────────────────────────────────────────────────

const AUTH_PAGES: RawPage[] = [
    { id: 'auth.login', label: 'Login', route: '/login', type: 'form', owner: 'auth', formRegistryId: 'auth.login', icon: '🔐' },
    { id: 'auth.register', label: 'Register', route: '/register', type: 'form', owner: 'auth', formRegistryId: 'auth.register', icon: '📝' },
    { id: 'auth.forgot-password', label: 'Forgot Password', route: '/forgot-password', type: 'form', owner: 'auth', formRegistryId: 'auth.forgot-password', icon: '🔑' },
    { id: 'auth.reset-password', label: 'Reset Password', route: '/reset-password', type: 'form', owner: 'auth', formRegistryId: 'auth.reset-password', icon: '🔑' },
    { id: 'auth.onboard-business', label: 'Onboard Business', route: '/onboard-business', type: 'form', owner: 'auth', formRegistryId: 'auth.onboard-business', icon: '🏢' },
];

const ERROR_PAGES: RawPage[] = [
    { id: 'error.404', label: 'Not Found', route: '/shared/404', type: 'error', owner: 'shared', icon: '🚫' },
    { id: 'error.401', label: 'Unauthorized', route: '/shared/401', type: 'error', owner: 'shared', icon: '🔒' },
    { id: 'error.500', label: 'Server Error', route: '/shared/500', type: 'error', owner: 'shared', icon: '💥' },
];

const FORM_PAGES: { id: string; label: string; route: string; owner: PageEntry['owner'] }[] = [
    { id: 'admin.admission', label: 'Client Admission', route: '/platform/admin/admission', owner: 'admin' },
    { id: 'admin.onboarding', label: 'Staff Onboarding', route: '/platform/admin/onboarding', owner: 'admin' },
    { id: 'admin.timesheet-adjust', label: 'Timesheet Adjustment', route: '/platform/admin/timesheets/adjust', owner: 'admin' },
    { id: 'admin.user-entry', label: 'Create / Edit User', route: '/platform/admin/users/new', owner: 'admin' },
    { id: 'admin.incident-entry', label: 'Create Incident', route: '/platform/admin/incidents/new', owner: 'admin' },
    { id: 'admin.lead-entry', label: 'Create Lead', route: '/platform/admin/leads/new', owner: 'admin' },
    { id: 'admin.locations', label: 'Location Form', route: '/platform/admin/locations', owner: 'admin' },
    { id: 'psw.handover', label: 'Shift Handover', route: '/tenancy/psw/handover', owner: 'psw' },
    { id: 'psw.expenses', label: 'Expense Claim', route: '/tenancy/psw/expenses', owner: 'psw' },
    { id: 'psw.availability', label: 'Availability', route: '/tenancy/psw/availability', owner: 'psw' },
    { id: 'client.feedback', label: 'Submit Feedback', route: '/tenancy/client/feedback', owner: 'client' },
    { id: 'client.booking-request', label: 'Request Booking', route: '/tenancy/client/request-booking', owner: 'client' },
];

// ── Build Function ───────────────────────────────────────────────────────────

export function buildPageEntries(): PageEntry[] {
    const raw: RawPage[] = [];

    raw.push(...AUTH_PAGES);
    raw.push(...ERROR_PAGES);

    DashboardRegistry.forEach(d => raw.push({
        id: `page.${d.id}`, label: d.label, route: d.route, type: 'home',
        owner: d.owner, icon: d.icon, dashboardRegistryId: d.id,
    } as RawPage));

    ListRegistry.forEach(l => raw.push({
        id: `page.${l.id}`, label: l.label, route: l.route, type: 'list', owner: l.owner,
    } as RawPage));

    HubRegistry.forEach(h => raw.push({
        id: `page.${h.id}`, label: h.label, route: h.route, type: 'hub',
        owner: h.owner, description: h.description,
    } as RawPage));

    WizardRegistry.forEach(w => raw.push({
        id: `page.${w.id}`, label: w.label, route: w.route, type: 'wizard',
        owner: w.owner, formRegistryId: w.formRegistryId,
    } as RawPage));

    ReportRegistry.forEach(r => raw.push({
        id: `page.${r.id}`, label: r.label, route: r.route, type: 'report', owner: r.owner,
    } as RawPage));

    ToolRegistry.forEach(t => raw.push({
        id: `page.${t.id}`, label: t.label, route: t.route, type: 'tool',
        owner: t.owner, description: t.description,
    } as RawPage));

    FORM_PAGES.forEach(f => raw.push({
        id: `page.${f.id}`, label: f.label, route: f.route, type: 'form',
        owner: f.owner, formRegistryId: f.id,
    } as RawPage));

    raw.push(
        { id: 'page.shared.profile', label: 'Profile', route: '/profile', type: 'form', owner: 'shared', formRegistryId: 'shared.profile' } as RawPage,
        { id: 'page.shared.messaging', label: 'Messaging', route: '/messaging', type: 'tool', owner: 'shared' } as RawPage,
        { id: 'page.shared.support', label: 'Support', route: '/support', type: 'hub', owner: 'shared' } as RawPage,
        { id: 'page.shared.learn', label: 'Learning Center', route: '/learn', type: 'portal', owner: 'shared' } as RawPage,
    );

    raw.push(
        { id: 'page.admin.form-registry', label: 'Form Registry', route: '/platform/admin/form-registry', type: 'registry', owner: 'admin', icon: '📋' } as RawPage,
        { id: 'page.admin.page-registry', label: 'Page Registry', route: '/platform/admin/page-registry', type: 'registry', owner: 'admin', icon: '📖' } as RawPage,
    );

    const categoryCounters: Record<string, number> = {};
    const pages: PageEntry[] = raw.map((entry, index) => {
        const prefix = CATEGORY_PREFIXES[entry.type] || 'X';
        categoryCounters[prefix] = (categoryCounters[prefix] || 0) + 1;
        const srNo = index + 1;
        const categoryCode = `${prefix}${categoryCounters[prefix]}`;
        return {
            ...entry,
            srNo,
            categoryCode,
            originalLabel: entry.label,
            label: `[#${srNo} ${categoryCode}] ${entry.label}`,
        } as PageEntry;
    });

    return pages;
}
