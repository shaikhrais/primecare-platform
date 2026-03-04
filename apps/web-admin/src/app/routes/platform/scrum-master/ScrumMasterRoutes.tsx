import React, { lazy } from 'react';
import { Route } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import RequireRole from '@/shared/rbac/RequireRole';
import AppLayout from '@/shared/components/layout/AppLayout';

const { RouteRegistry } = AdminRegistry;

// Scrum Master Pages
const ScrumMasterDashboard = lazy(() => import('./pages/dashboard'));
const ApiEndpointsHub = lazy(() => import('./pages/testing/ApiEndpointsHub'));
const TechnicalAuditPortal = lazy(() => import('./pages/audit/TechnicalAuditPortal'));
const RoleFlowsPage = lazy(() => import('./pages/flows/RoleFlowsPage'));
const SystemHealthMonitor = lazy(() => import('./pages/monitoring/SystemHealthMonitor'));
const EnvironmentAudit = lazy(() => import('./pages/audit/EnvironmentAudit'));
const RegistryIntegrityCheck = lazy(() => import('./pages/audit/RegistryIntegrityCheck'));
const DatabaseSchemaAudit = lazy(() => import('./pages/audit/DatabaseSchemaAudit'));
const ThemeCoreCenter = lazy(() => import('./pages/theme/ThemeCoreCenter'));

export const ScrumMasterRoutes = () => (
    <Route path={RouteRegistry.SCRUM_MASTER.DASHBOARD} element={<RequireRole allowedRoles={['scrum_master']}><AppLayout /></RequireRole>}>
        <Route index element={<ScrumMasterDashboard />} />
        <Route path={RouteRegistry.SCRUM_MASTER.API_ENDPOINTS} element={<ApiEndpointsHub />} />
        <Route path={RouteRegistry.SCRUM_MASTER.PAGES} element={<TechnicalAuditPortal />} />
        <Route path={RouteRegistry.SCRUM_MASTER.COMPONENTS} element={<TechnicalAuditPortal />} />
        <Route path={RouteRegistry.SCRUM_MASTER.ROLE_FLOWS} element={<RoleFlowsPage />} />
        <Route path={RouteRegistry.SCRUM_MASTER.MONITORING} element={<SystemHealthMonitor />} />
        <Route path={RouteRegistry.SCRUM_MASTER.ENV_AUDIT} element={<EnvironmentAudit />} />
        <Route path={RouteRegistry.SCRUM_MASTER.REGISTRY_CHECK} element={<RegistryIntegrityCheck />} />
        <Route path={RouteRegistry.SCRUM_MASTER.DATABASE_SCHEMA} element={<DatabaseSchemaAudit />} />
        <Route path={RouteRegistry.SCRUM_MASTER.THEME_CENTER} element={<ThemeCoreCenter />} />
    </Route>
);
