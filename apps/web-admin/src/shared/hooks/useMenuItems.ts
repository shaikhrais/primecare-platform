/**
 * useMenuItems — Registry-Driven Sidebar Menu Builder
 *
 * Replaces the hardcoded menu-configs.ts with a dynamic approach that reads
 * from the LinkRegistry (ButtonRegistry type:'link') to auto-generate sidebar
 * navigation per role. Icons are mapped from a lookup table.
 *
 * ADDING A NEW SIDEBAR LINK:
 *   1. Add a link entry in LINK_ENTRIES (ButtonRegistry.ts) with the correct role
 *   2. Optionally add an icon in ICON_MAP below
 *   3. Done — sidebar auto-updates
 */
import { useMemo } from 'react';
import { AdminRegistry, getLinksForRole } from 'prime-care-shared';

const { RouteRegistry, ContentRegistry } = AdminRegistry;

export interface MenuItem {
    label: string;
    path: string;
    icon: string;
}

// ── Icon Lookup: link id prefix → emoji ──────────────────────────────────────
// Falls back to '📄' if not found. Add new icons here when adding new links.
const ICON_MAP: Record<string, string> = {
    // Admin
    'lnk-admin-audit-logs': '🎙️', 'lnk-admin-users': '👥', 'lnk-admin-schedule': '📅',
    'lnk-admin-incidents': '🚨', 'lnk-admin-timesheets': '⏰', 'lnk-admin-leads': '📥',
    'lnk-admin-services': '💰', 'lnk-admin-settings': '⚙️', 'lnk-admin-content': '📝',
    'lnk-admin-admission': '📝', 'lnk-admin-reports': '📈', 'lnk-admin-setup-wizard': '🧙',
    'lnk-admin-search': '🔍', 'lnk-adm-customers': '👤', 'lnk-adm-earnings': '💵',
    'lnk-adm-interop': '🔗', 'lnk-adm-locations': '📍',
    'lnk-ops-logistics': '🚚', 'lnk-ops-regions': '🗺️',
    'lnk-erp-inventory': '📦', 'lnk-erp-procurement': '🛒',
    'lnk-telehealth-center': '🏥', 'lnk-telehealth-admin-home': '🏥',
    'lnk-rcm-claims': '💳', 'lnk-rcm-revenue': '💹',
    'lnk-pharmacy-hub': '💊', 'lnk-pharmacy-mar': '💊',
    'lnk-evv-exceptions': '📍', 'lnk-admin-consent-forms': '📜', 'lnk-admin-authorizations': '🔑',
    // Scrum Master
    'lnk-sm-api-hub': '🔌', 'lnk-sm-monitoring': '💓', 'lnk-sm-env-audit': '🌐',
    'lnk-sm-registry-check': '📋', 'lnk-sm-db-schema': '🗄️', 'lnk-sm-build-health': '🏗️',
    'lnk-sm-security-scans': '🛡️', 'lnk-sm-localization': '🌍', 'lnk-sm-auto-fix': '🔧',
    'lnk-sm-impersonate': '🎭', 'lnk-sm-response-bot': '🤖', 'lnk-sm-perf-metrics': '⚡',
    'lnk-sm-theme-lab': '🎨',
    // Manager
    'lnk-mgr-home': '📊', 'lnk-mgr-pl': '💰', 'lnk-mgr-ops': '🔧',
    'lnk-mgr-compliance': '✅', 'lnk-mgr-team': '👥', 'lnk-mgr-finance': '💵',
    'lnk-mgr-ops-hub': '🏢',
    // Premium — Manager
    'lnk-mgr-gamification': '🎮', 'lnk-mgr-iot': '📡', 'lnk-mgr-doc-signing': '✍️',
    'lnk-mgr-sms-hub': '📱', 'lnk-mgr-perf-reviews': '📊', 'lnk-mgr-training-academy': '🎓',
    // Premium — Admin
    'lnk-admin-ai-command': '🧠', 'lnk-admin-multi-currency': '💱', 'lnk-admin-audit-trail': '🔍',
    'lnk-admin-franchise': '🏢', 'lnk-admin-supply-chain': '📦',
    // Premium — PSW
    'lnk-psw-guide': '📖',
    // PSW
    'lnk-psw-offers': '✨', 'lnk-psw-handover': '📋', 'lnk-psw-availability': '🗓️',
    'lnk-psw-availability-my': '🗓️', 'lnk-psw-earnings': '💰', 'lnk-psw-live-visit': '🩺',
    // RN
    'lnk-rn-supervision': '👁️', 'lnk-rn-supervision-field': '👁️',
    'lnk-rn-care-plans': '📋', 'lnk-rn-care-plans-2': '📋',
    'lnk-rn-ops-verify': '✅', 'lnk-rn-assessments': '📝',
    'lnk-rn-wound-care': '🩹', 'lnk-rn-rai-assessments': '📊',
    // Coordinator
    'lnk-coord-hub': '📊', 'lnk-coord-sos': '🆘', 'lnk-coord-map': '🗺️',
    'lnk-coord-waitlist': '📋', 'lnk-coord-master-schedule': '📅', 'lnk-coordinator-sos-hub': '🆘',
    // Client
    'lnk-client-support': '💬', 'lnk-client-team': '👥', 'lnk-client-billing': '💳',
    'lnk-client-medical-summary': '🏥', 'lnk-client-family-portal': '👨‍👩‍👧',
    // Staff
    'lnk-staff-incidents': '⚠️', 'lnk-staff-tasks': '📋', 'lnk-staff-messages': '💬',
    // Superuser
    'lnk-superuser-tenants': '🏢', 'lnk-superuser-sla': '📊',
    // Finance Director
    'lnk-fd-home': '🏛️', 'lnk-fd-ledger': '🏦', 'lnk-fd-tax-hub': '💰', 'lnk-fd-reconciliation': '🔄',
    // Regional
    'lnk-rd-regional': '🌐', 'lnk-rd-finance': '💵',
    // RPM
    'lnk-rpm-alerts': '🔔',
};

// ── Home paths per role ─────────────────────────────────────────────────
const HOME_MAP: Record<string, { label: string; path: string; icon: string }> = {
    admin:            { label: ContentRegistry.MENU.HOME, path: RouteRegistry.ADMIN.HOME, icon: '📊' },
    super_admin:      { label: 'Platform Stats',               path: RouteRegistry.SUPERUSER.HOME, icon: '👑' },
    scrum_master:     { label: 'Scrum Home',               path: RouteRegistry.SCRUM_MASTER.HOME, icon: '🚀' },
    manager:          { label: ContentRegistry.MENU.HOME,  path: RouteRegistry.MANAGER.HOME, icon: '📊' },
    regional_manager: { label: 'Regional HQ',                   path: RouteRegistry.MANAGER.REGIONAL_STATS, icon: '🌐' },
    coordinator:      { label: ContentRegistry.MENU.HOME,  path: RouteRegistry.COORDINATOR.HOME, icon: '📍' },
    psw:              { label: ContentRegistry.MENU.WORK_SCHEDULE, path: RouteRegistry.PSW.HOME, icon: '🗓️' },
    rn:               { label: ContentRegistry.MENU.CLINICAL_HOME, path: RouteRegistry.RN.HOME, icon: '🩺' },
    client:           { label: ContentRegistry.MENU.CLIENT_HUB, path: RouteRegistry.CLIENT.HOME, icon: '🏠' },
    staff:            { label: ContentRegistry.MENU.STAFF_HUB,  path: RouteRegistry.STAFF.HOME, icon: '🏢' },
    finance:          { label: 'Finance Hub',                   path: RouteRegistry.ADMIN.FINANCE.HOME, icon: '💰' },
    finance_director: { label: 'Finance Intelligence',          path: RouteRegistry.ADMIN.FINANCE.HOME, icon: '🏛️' },
};

// ── Shared items every role gets at the bottom ───────────────────────────────
function getSharedItems(role: string): MenuItem[] {
    return [
        { label: 'My Role Playbook', path: `${RouteRegistry.KNOWLEDGE_BASE}/role-${role}`, icon: '🎭' },
        { label: ContentRegistry.MENU.KNOWLEDGE_BASE, path: RouteRegistry.KNOWLEDGE_BASE, icon: '📚' },
        { label: ContentRegistry.MENU.TRAINING, path: RouteRegistry.LEARN, icon: '🎓' },
        { label: ContentRegistry.MENU.SUPPORT, path: RouteRegistry.SUPPORT, icon: '💬' },
    ];
}

/**
 * Build sidebar menu items from the registry for the given role.
 *
 * Order: Home → Registry links (deduplicated) → Shared (KB, Training, Support)
 */
export function useMenuItems(role: string): MenuItem[] {
    return useMemo(() => {
        const lowerRole = role.toLowerCase();

        // 1. Home entry
        const home = HOME_MAP[lowerRole] || HOME_MAP['client'];

        // 2. Role-specific links from ButtonRegistry
        const registryLinks = getLinksForRole(lowerRole);
        const roleLinks: MenuItem[] = registryLinks.map(link => ({
            label: link.label,
            path: link.path || '#',
            icon: ICON_MAP[link.id] || '📄',
        }));

        // 3. Shared tail items
        const shared = getSharedItems(lowerRole);

        // 4. Deduplicate by path (home + links + shared)
        const seen = new Set<string>();
        const result: MenuItem[] = [];
        for (const item of [home, ...roleLinks, ...shared]) {
            if (!seen.has(item.path)) {
                seen.add(item.path);
                result.push(item);
            }
        }

        return result;
    }, [role]);
}

export default useMenuItems;
