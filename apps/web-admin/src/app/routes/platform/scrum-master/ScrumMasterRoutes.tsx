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
const DeveloperPortal = lazy(() => import('./pages/developer'));
const DeveloperKBPage = lazy(() => import('./pages/developer-kb'));
const PerformancePage = lazy(() => import('./pages/performance/PerformancePage'));
const BuildHealthPage = lazy(() => import('./pages/builds/BuildHealthPage'));
const SecurityScansPage = lazy(() => import('./pages/scans/SecurityScansPage'));
const LocalizationPage = lazy(() => import('./pages/locales/LocalizationPage'));
const RegistryAutoRepair = lazy(() => import('./pages/repair/RegistryAutoRepair'));
const ImpersonationTool = lazy(() => import('./pages/impersonate/ImpersonationTool'));
const InteractionAudit = lazy(() => import('./pages/audit/InteractionAudit'));
const ResponseBot = lazy(() => import('./pages/audit/ResponseBot'));

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
        <Route path={RouteRegistry.SCRUM_MASTER.DEVELOPER} element={<DeveloperPortal />} />
        <Route path={RouteRegistry.SCRUM_MASTER.DEV_KB} element={<DeveloperKBPage />} />
        <Route path={RouteRegistry.SCRUM_MASTER.PERFORMANCE} element={<PerformancePage />} />
        <Route path={RouteRegistry.SCRUM_MASTER.BUILD_HEALTH} element={<BuildHealthPage />} />
        <Route path={RouteRegistry.SCRUM_MASTER.SECURITY_SCANS} element={<SecurityScansPage />} />
        <Route path={RouteRegistry.SCRUM_MASTER.LOCALIZATION} element={<LocalizationPage />} />
        <Route path={RouteRegistry.SCRUM_MASTER.AUTO_FIX} element={<RegistryAutoRepair />} />
        <Route path={RouteRegistry.SCRUM_MASTER.IMPERSONATE} element={<ImpersonationTool />} />
        <Route path={RouteRegistry.SCRUM_MASTER.INTERACTION_AUDIT} element={<InteractionAudit />} />
        <Route path={RouteRegistry.SCRUM_MASTER.RESPONSE_BOT} element={<ResponseBot />} />
    </Route>
);
