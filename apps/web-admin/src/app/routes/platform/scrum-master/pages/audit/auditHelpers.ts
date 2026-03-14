// TechnicalAuditPortal: route processing + static component data
import { useMemo } from 'react';
import { AdminRegistry } from 'prime-care-shared';
const { RouteRegistry } = AdminRegistry;

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
