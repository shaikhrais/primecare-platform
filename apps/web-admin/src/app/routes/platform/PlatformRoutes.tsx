import React, { lazy } from 'react';
import { Route } from 'react-router';
import { AdminRegistry } from 'prime-care-shared';
import RequireRole from '@/shared/rbac/RequireRole';
import AppLayout from '@/shared/components/layout/AppLayout';

const { RouteRegistry } = AdminRegistry;

// Platform Portal (Super Admin)
const PlatformDashboard = lazy(() => import('./dashboard').then(m => ({ default: Object.values(m)[0] as any })));
const PlatformAuditLogs = lazy(() => import('./audit-logs').then(m => ({ default: Object.values(m)[0] as any })));
const SLAMonitoring = lazy(() => import('./sla-monitoring'));
const RiskSurveillanceDashboard = lazy(() => import('./superuser/super-admin/pages').then(m => ({ default: Object.values(m)[0] as any })));
const TenantList = lazy(() => import('./tenants'));
const GovernanceHub = lazy(() => import('./governance-hub'));

const SystemPolicies = lazy(() => import('./policies').then(m => ({ default: Object.values(m)[0] as any })));

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
