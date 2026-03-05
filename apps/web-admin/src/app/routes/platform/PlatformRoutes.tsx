import React, { lazy } from 'react';
import { Route } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import RequireRole from '@/shared/rbac/RequireRole';
import AppLayout from '@/shared/components/layout/AppLayout';

const { RouteRegistry } = AdminRegistry;

// Platform Portal (Super Admin)
const PlatformDashboard = lazy(() => import('./pages/dashboard'));
const PlatformAuditLogs = lazy(() => import('./pages/audit-logs'));
const SLAMonitoring = lazy(() => import('./pages/sla-monitoring'));
const RiskSurveillanceDashboard = lazy(() => import('./superuser/super-admin/pages/RiskSurveillanceDashboard'));
const TenantList = lazy(() => import('./pages/tenants'));
const GovernanceHub = lazy(() => import('./pages/governance-hub'));

export const PlatformRoutes = () => (
    <Route path={RouteRegistry.SUPERUSER.DASHBOARD} element={<RequireRole allowedRoles={['super_admin']}><AppLayout /></RequireRole>}>
        <Route index element={<PlatformDashboard />} />
        <Route path={RouteRegistry.SUPERUSER.TENANTS} element={<TenantList />} />
        <Route path={RouteRegistry.SUPERUSER.AUDIT_LOGS} element={<PlatformAuditLogs />} />
        <Route path={RouteRegistry.SUPERUSER.SLA} element={<SLAMonitoring />} />
        <Route path={RouteRegistry.SUPERUSER.RISK_SURVEILLANCE} element={<RiskSurveillanceDashboard />} />
        <Route path={RouteRegistry.SUPERUSER.GOVERNANCE_HUB} element={<GovernanceHub />} />
    </Route>
);
