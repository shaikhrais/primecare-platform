import React, { lazy } from 'react';
import { Route } from 'react-router';
import { AdminRegistry } from 'prime-care-shared';
import RequireRole from '@/shared/rbac/RequireRole';
import AppLayout from '@/shared/components/layout/AppLayout';

const { RouteRegistry } = AdminRegistry;

// Scrum Master Pages
const ScrumMasterDashboard = lazy(() => import('../../tenancy/staff/dashboard').then(m => ({ default: Object.values(m)[0] as any })));
const ApiEndpointsHub = lazy(() => import('./testing').then(m => ({ default: Object.values(m)[0] as any })));
const TechnicalAuditPortal = lazy(() => import('../../tenancy/rn/audit').then(m => ({ default: Object.values(m)[0] as any })));
const RoleFlowsPage = lazy(() => import('./flows').then(m => ({ default: Object.values(m)[0] as any })));
const SystemHealthMonitor = lazy(() => import('./monitoring').then(m => ({ default: Object.values(m)[0] as any })));
const EnvironmentAudit = lazy(() => import('../../tenancy/rn/audit').then(m => ({ default: Object.values(m)[0] as any })));
const RegistryIntegrityCheck = lazy(() => import('../../tenancy/rn/audit').then(m => ({ default: Object.values(m)[0] as any })));
const DatabaseSchemaAudit = lazy(() => import('../../tenancy/rn/audit').then(m => ({ default: Object.values(m)[0] as any })));
const ThemeCoreCenter = lazy(() => import('./theme').then(m => ({ default: Object.values(m)[0] as any })));
const DeveloperPortal = lazy(() => import('./developer').then(m => ({ default: Object.values(m)[0] as any })));
const DeveloperKBPage = lazy(() => import('./developer-kb').then(m => ({ default: Object.values(m)[0] as any })));
const PerformancePage = lazy(() => import('../../tenancy/manager/performance').then(m => ({ default: Object.values(m)[0] as any })));
const BuildHealthPage = lazy(() => import('./builds').then(m => ({ default: Object.values(m)[0] as any })));
const SecurityScansPage = lazy(() => import('./scans').then(m => ({ default: Object.values(m)[0] as any })));
const LocalizationPage = lazy(() => import('./locales').then(m => ({ default: Object.values(m)[0] as any })));
const RegistryAutoRepair = lazy(() => import('./repair').then(m => ({ default: Object.values(m)[0] as any })));
const ImpersonationTool = lazy(() => import('./impersonate').then(m => ({ default: Object.values(m)[0] as any })));
const InteractionAudit = lazy(() => import('../../tenancy/rn/audit').then(m => ({ default: Object.values(m)[0] as any })));
const ResponseBot = lazy(() => import('../../tenancy/rn/audit').then(m => ({ default: Object.values(m)[0] as any })));
const UsageStatisticsManager = lazy(() => import('./usage').then(m => ({ default: Object.values(m)[0] as any })));
const DigitalPropertyManager = lazy(() => import('./property').then(m => ({ default: Object.values(m)[0] as any })));
const E2eRunner = lazy(() => import('./e2e-runner').then(m => ({ default: Object.values(m)[0] as any })));

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
        <Route path="e2e-runner" element={<E2eRunner />} />
    </Route>
);
