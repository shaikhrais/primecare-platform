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
const UsageStatisticsManager = lazy(() => import('./pages/usage/UsageStatisticsManager'));
const DigitalPropertyManager = lazy(() => import('./pages/property/DigitalPropertyManager'));

export const ScrumMasterRoutes = () => (
    <Route path={`${RouteRegistry.SCRUM_MASTER.DASHBOARD}/*`} element={<RequireRole allowedRoles={['scrum_master']}><AppLayout /></RequireRole>}>
        <Route index element={<ScrumMasterDashboard />} />
        <Route path="api-endpoints" element={<ApiEndpointsHub />} />
        <Route path="pages" element={<TechnicalAuditPortal />} />
        <Route path="components" element={<TechnicalAuditPortal />} />
        <Route path="role-flows" element={<RoleFlowsPage />} />
        <Route path="monitoring" element={<SystemHealthMonitor />} />
        <Route path="env-audit" element={<EnvironmentAudit />} />
        <Route path="registry-check" element={<RegistryIntegrityCheck />} />
        <Route path="database-schema" element={<DatabaseSchemaAudit />} />
        <Route path="theme-center" element={<ThemeCoreCenter />} />
        <Route path="developer" element={<DeveloperPortal />} />
        <Route path="dev-kb" element={<DeveloperKBPage />} />
        <Route path="performance" element={<PerformancePage />} />
        <Route path="build-health" element={<BuildHealthPage />} />
        <Route path="security-scans" element={<SecurityScansPage />} />
        <Route path="localization" element={<LocalizationPage />} />
        <Route path="auto-fix" element={<RegistryAutoRepair />} />
        <Route path="impersonate" element={<ImpersonationTool />} />
        <Route path="interaction-audit" element={<InteractionAudit />} />
        <Route path="response-bot" element={<ResponseBot />} />
        <Route path="usage-stats" element={<UsageStatisticsManager />} />
        <Route path="digital-property" element={<DigitalPropertyManager />} />
    </Route>
);
