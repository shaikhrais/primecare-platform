/**
 * Component Exports — Module Structure Tests
 *
 * Tests all shared components (non-chart) for proper exports:
 * design-system, forms, layout, modals, forensics, media, etc.
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// Design System Barrel
// ═══════════════════════════════════════════════════════════════════════════

describe('Design System', () => {
    it('LoadingSkeleton exports', async () => {
        const mod: any = await import('@/shared/components/design-system/LoadingSkeleton');
        expect(mod.LoadingSkeleton).toBeDefined();
    });

    it('StatusBadge exports', async () => {
        const mod: any = await import('@/shared/components/design-system/StatusBadge');
        expect(mod.StatusBadge).toBeDefined();
    });

    it('DataCard exports', async () => {
        const mod: any = await import('@/shared/components/design-system/DataCard');
        expect(mod.DataCard).toBeDefined();
    });

    it('barrel re-exports all 3 design-system components', async () => {
        const mod: any = await import('@/shared/components/design-system');
        expect(mod.LoadingSkeleton).toBeDefined();
        expect(mod.StatusBadge).toBeDefined();
        expect(mod.DataCard).toBeDefined();
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Forms
// ═══════════════════════════════════════════════════════════════════════════

describe('Form Components', () => {
    it('InlineCreatorPopover exports', async () => {
        const mod: any = await import('@/shared/components/forms/InlineCreatorPopover');
        expect(mod.InlineCreatorPopover).toBeDefined();
    });

    it('DynamicFormRenderer exports', async () => {
        const mod: any = await import('@/shared/components/forms/DynamicFormRenderer');
        expect(mod.DynamicFormRenderer).toBeDefined();
    });

    it('renderField exports', async () => {
        const mod: any = await import('@/shared/components/forms/renderField');
        const exp = mod.renderField || mod.default;
        expect(exp).toBeDefined();
    });

    it('forms barrel re-exports', async () => {
        const mod: any = await import('@/shared/components/forms');
        expect(mod.InlineCreatorPopover).toBeDefined();
        expect(mod.DynamicFormRenderer).toBeDefined();
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Top-Level Shared Components (static imports)
// ═══════════════════════════════════════════════════════════════════════════

describe('Top-Level Shared Components', () => {
    it('CommandPalette exports', async () => {
        const mod: any = await import('@/shared/components/CommandPalette');
        const c = mod.CommandPalette || mod.default;
        expect(c).toBeDefined();
    });
    it('CommandPaletteWrapper exports', async () => {
        const mod: any = await import('@/shared/components/CommandPaletteWrapper');
        const c = mod.CommandPaletteWrapper || mod.default;
        expect(c).toBeDefined();
    });
    it('ErrorBoundary exports', async () => {
        const mod: any = await import('@/shared/components/ErrorBoundary');
        const c = mod.ErrorBoundary || mod.default;
        expect(c).toBeDefined();
    });
    it('PermissionGuard exports', async () => {
        const mod: any = await import('@/shared/components/PermissionGuard');
        const c = mod.PermissionGuard || mod.default;
        expect(c).toBeDefined();
    });
    it('QuickActions exports', async () => {
        const mod: any = await import('@/shared/components/QuickActions');
        const c = mod.QuickActions || mod.default;
        expect(c).toBeDefined();
    });
    it('SmartBreadcrumbs exports', async () => {
        const mod: any = await import('@/shared/components/SmartBreadcrumbs');
        const c = mod.SmartBreadcrumbs || mod.default;
        expect(c).toBeDefined();
    });
    it('ToastContainer exports', async () => {
        const mod: any = await import('@/shared/components/ToastContainer');
        const c = mod.ToastContainer || mod.default;
        expect(c).toBeDefined();
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Layout Components (static imports)
// ═══════════════════════════════════════════════════════════════════════════

describe('Layout Components', () => {
    it('AppLayout exports', async () => {
        const mod: any = await import('@/shared/components/layout/AppLayout');
        const c = mod.AppLayout || mod.default;
        expect(c).toBeDefined();
    });
    it('DevPerspectiveSwitcher exports', async () => {
        const mod: any = await import('@/shared/components/layout/DevPerspectiveSwitcher');
        const c = mod.DevPerspectiveSwitcher || mod.default;
        expect(c).toBeDefined();
    });
    it('EmptyState exports', async () => {
        const mod: any = await import('@/shared/components/layout/EmptyState');
        const c = mod.EmptyState || mod.default;
        expect(c).toBeDefined();
    });
    it('GlobalQuickActionBar exports', async () => {
        const mod: any = await import('@/shared/components/layout/GlobalQuickActionBar');
        const c = mod.GlobalQuickActionBar || mod.default;
        expect(c).toBeDefined();
    });
    it('ImpersonationBanner exports', async () => {
        const mod: any = await import('@/shared/components/layout/ImpersonationBanner');
        const c = mod.ImpersonationBanner || mod.default;
        expect(c).toBeDefined();
    });
    it('NotificationHub exports', async () => {
        const mod: any = await import('@/shared/components/layout/NotificationHub');
        const c = mod.NotificationHub || mod.default;
        expect(c).toBeDefined();
    });
    it('OfflineIndicator exports', async () => {
        const mod: any = await import('@/shared/components/layout/OfflineIndicator');
        const c = mod.OfflineIndicator || mod.default;
        expect(c).toBeDefined();
    });
    it('PswBottomNav exports', async () => {
        const mod: any = await import('@/shared/components/layout/PswBottomNav');
        const c = mod.PswBottomNav || mod.default;
        expect(c).toBeDefined();
    });
    it('RoleSwitcher exports', async () => {
        const mod: any = await import('@/shared/components/layout/RoleSwitcher');
        const c = mod.RoleSwitcher || mod.default;
        expect(c).toBeDefined();
    });
    it('SideFloatingButton exports', async () => {
        const mod: any = await import('@/shared/components/layout/SideFloatingButton');
        const c = mod.SideFloatingButton || mod.default;
        expect(c).toBeDefined();
    });
    it('Sidebar exports', async () => {
        const mod: any = await import('@/shared/components/layout/Sidebar');
        const c = mod.Sidebar || mod.default;
        expect(c).toBeDefined();
    });
    it('SosButton exports', async () => {
        const mod: any = await import('@/shared/components/layout/SosButton');
        const c = mod.SosButton || mod.default;
        expect(c).toBeDefined();
    });
    it('SystemHealthFooter exports', async () => {
        const mod: any = await import('@/shared/components/layout/SystemHealthFooter');
        const c = mod.SystemHealthFooter || mod.default;
        expect(c).toBeDefined();
    });
    it('TopBar exports', async () => {
        const mod: any = await import('@/shared/components/layout/TopBar');
        const c = mod.TopBar || mod.default;
        expect(c).toBeDefined();
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Layout Config Files
// ═══════════════════════════════════════════════════════════════════════════

describe('Layout Config Files', () => {
    it('menu-configs exports configuration', async () => {
        const mod: any = await import('@/shared/components/layout/menu-configs');
        expect(Object.keys(mod).length).toBeGreaterThan(0);
    });

    it('manager-role-menus exports configuration', async () => {
        const mod: any = await import('@/shared/components/layout/manager-role-menus');
        expect(Object.keys(mod).length).toBeGreaterThan(0);
    });

    it('kb-menu-configs exports configuration', async () => {
        const mod: any = await import('@/shared/components/layout/kb-menu-configs');
        expect(Object.keys(mod).length).toBeGreaterThan(0);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Layout Sub-Components
// ═══════════════════════════════════════════════════════════════════════════

describe('Layout Sub-Components', () => {
    it('PerspectiveModal exports', async () => {
        const mod: any = await import('@/shared/components/layout/switcher/PerspectiveModal');
        const component = mod.PerspectiveModal || mod.default;
        expect(component).toBeDefined();
    });

    it('RoleSwitcherModal exports', async () => {
        const mod: any = await import('@/shared/components/layout/switcher/RoleSwitcherModal');
        const component = mod.RoleSwitcherModal || mod.default;
        expect(component).toBeDefined();
    });

    it('FlagLanguageSwitcher exports', async () => {
        const mod: any = await import('@/shared/components/layout/topbar/FlagLanguageSwitcher');
        const component = mod.FlagLanguageSwitcher || mod.default;
        expect(component).toBeDefined();
    });

    it('TopBarActions exports', async () => {
        const mod: any = await import('@/shared/components/layout/topbar/TopBarActions');
        const component = mod.TopBarActions || mod.default;
        expect(component).toBeDefined();
    });

    it('TopBarIdentity exports', async () => {
        const mod: any = await import('@/shared/components/layout/topbar/TopBarIdentity');
        const component = mod.TopBarIdentity || mod.default;
        expect(component).toBeDefined();
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Forensics Components
// ═══════════════════════════════════════════════════════════════════════════

describe('Forensics Components', () => {
    it('AuditTimeline exports', async () => {
        const mod: any = await import('@/shared/components/forensics/AuditTimeline');
        const component = mod.AuditTimeline || mod.default;
        expect(component).toBeDefined();
    });

    it('NoShowProbability exports', async () => {
        const mod: any = await import('@/shared/components/forensics/NoShowProbability');
        const component = mod.NoShowProbability || mod.default;
        expect(component).toBeDefined();
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Media Components
// ═══════════════════════════════════════════════════════════════════════════

describe('Media Components', () => {
    it('SecureCamera exports', async () => {
        const mod: any = await import('@/shared/components/media/SecureCamera');
        const component = mod.SecureCamera || mod.default;
        expect(component).toBeDefined();
    });

    it('VoiceDictationButton exports', async () => {
        const mod: any = await import('@/shared/components/media/VoiceDictationButton');
        const component = mod.VoiceDictationButton || mod.default;
        expect(component).toBeDefined();
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Communications Components
// ═══════════════════════════════════════════════════════════════════════════

describe('Communications Components', () => {
    it('SoftphoneWidget exports', async () => {
        const mod: any = await import('@/shared/components/communications/SoftphoneWidget');
        const component = mod.SoftphoneWidget || mod.default;
        expect(component).toBeDefined();
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Modal Components (static imports)
// ═══════════════════════════════════════════════════════════════════════════

describe('Modal Components', () => {
    it('ConfirmModal exports', async () => {
        const mod: any = await import('@/shared/components/modals/ConfirmModal');
        const c = mod.ConfirmModal || mod.default;
        expect(c).toBeDefined();
    });
    it('CreateShiftModal exports', async () => {
        const mod: any = await import('@/shared/components/modals/CreateShiftModal');
        const c = mod.CreateShiftModal || mod.default;
        expect(c).toBeDefined();
    });
    it('CreateVisitModal exports', async () => {
        const mod: any = await import('@/shared/components/modals/CreateVisitModal');
        const c = mod.CreateVisitModal || mod.default;
        expect(c).toBeDefined();
    });
    it('CustomerQuickViewModal exports', async () => {
        const mod: any = await import('@/shared/components/modals/CustomerQuickViewModal');
        const c = mod.CustomerQuickViewModal || mod.default;
        expect(c).toBeDefined();
    });
    it('DangerModal exports', async () => {
        const mod: any = await import('@/shared/components/modals/DangerModal');
        const c = mod.DangerModal || mod.default;
        expect(c).toBeDefined();
    });
    it('DangerZoneModal exports', async () => {
        const mod: any = await import('@/shared/components/modals/DangerZoneModal');
        const c = mod.DangerZoneModal || mod.default;
        expect(c).toBeDefined();
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Dashboard Components
// ═══════════════════════════════════════════════════════════════════════════

describe('Dashboard Components', () => {
    it('QuickActions exports', async () => {
        const mod: any = await import('@/shared/components/dashboard/QuickActions');
        const component = mod.QuickActions || mod.default;
        expect(component).toBeDefined();
    });
});
