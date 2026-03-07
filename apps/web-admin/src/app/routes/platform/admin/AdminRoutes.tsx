import React, { lazy } from 'react';
import { Route } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import RequireRole from '@/shared/rbac/RequireRole';
import AppLayout from '@/shared/components/layout/AppLayout';

const { RouteRegistry } = AdminRegistry;

// Admin components (Eagerly loaded to avoid layout shifts on dashboard)
import AdminDashboard from './pages/dashboard';
import RegistrySummaryDashboard from './pages/dashboard/RegistrySummaryDashboard';
import { UserList, UserEntry } from './pages/users';
import AdminEarningsPage from './pages/earnings';

// Admin Pages (Lazy loaded)
const Schedule = lazy(() => import('./pages/schedule'));
const IncidentList = lazy(() => import('./pages/incidents').then(m => ({ default: m.IncidentList })));
const IncidentEntry = lazy(() => import('./pages/incidents').then(m => ({ default: m.IncidentEntry })));
const LeadsPage = lazy(() => import('./pages/leads').then(m => ({ default: m.LeadsPage })));
const LeadEntryForm = lazy(() => import('./pages/leads').then(m => ({ default: m.LeadEntryForm })));
const LeadConversion = lazy(() => import('./pages/leads').then(m => ({ default: m.LeadConversion })));
const LogisticsHub = lazy(() => import('../../tenancy/admin/pages/ops/LogisticsHub'));
const RegionMapping = lazy(() => import('../../tenancy/admin/pages/ops/RegionMapping'));
const RealtimeCapacity = lazy(() => import('../../tenancy/admin/pages/ops/RealtimeCapacity'));
const Timesheets = lazy(() => import('./pages/timesheets'));
const TimesheetAdjustment = lazy(() => import('./pages/timesheet-adjustment'));
const Services = lazy(() => import('./pages/services'));
const Settings = lazy(() => import('./pages/settings'));
const ContentManager = lazy(() => import('./pages/content'));
const AuditLogs = lazy(() => import('./pages/audits'));
const LeadAdmission = lazy(() => import('./pages/admission'));
const Onboarding = lazy(() => import('./pages/onboarding'));
const ReportCenter = lazy(() => import('./pages/reports'));
const InvoicesNew = lazy(() => import('./pages/invoices').then(m => ({ default: m.InvoiceEntry })));
const BusinessSetupWizard = lazy(() => import('./pages/setup/BusinessSetupWizard'));
const WizardHub = lazy(() => import('./pages/setup/WizardHub'));
const StaffOnboardingWizard = lazy(() => import('./pages/setup/StaffOnboardingWizard'));
const CarePlanWizard = lazy(() => import('./pages/setup/CarePlanWizard'));
const RevenueWizard = lazy(() => import('./pages/setup/RevenueWizard'));
const BusinessModelWizard = lazy(() => import('./pages/setup/BusinessModelWizard'));
const BusinessStatus = lazy(() => import('./pages/setup/BusinessStatus'));
const KnowledgeBaseIndex = lazy(() => import('./pages/knowledge-base/KnowledgeBaseIndex'));
const KnowledgeBaseArticle = lazy(() => import('./pages/knowledge-base/KnowledgeBaseArticle'));
const AIInsights = lazy(() => import('./pages/insights'));
const ClinicalAssistant = lazy(() => import('./pages/clinical-assistant'));
const AutoPilotDashboard = lazy(() => import('./pages/automation/AutoPilotDashboard'));
const FHIRCenter = lazy(() => import('./pages/interoperability/FHIRCenter'));
const SovereignWallet = lazy(() => import('./pages/sovereign/SovereignWallet'));
const Locations = lazy(() => import('./pages/locations'));
const RoleEditor = lazy(() => import('./pages/role-editor'));
const AdminCustomerList = lazy(() => import('./pages/customers'));
const TemplateEditor = lazy(() => import('./pages/template-editor'));
const SearchPage = lazy(() => import('./pages/search/SearchPage'));
const ExportPage = lazy(() => import('./pages/reports/ExportPage'));
const SupplyChainHub = lazy(() => import('./pages/erp/SupplyChainHub'));
const TelehealthCenter = lazy(() => import('./pages/telehealth/TelehealthCenter'));
const RevenueCycleHub = lazy(() => import('./pages/rcm/RevenueCycleHub'));
const PharmacyHub = lazy(() => import('./pages/pharmacy/PharmacyHub'));
const SecurityGovernance = lazy(() => import('./pages/security/SecurityGovernance'));
const DeviceManagement = lazy(() => import('./pages/security/DeviceManagement'));

export const AdminRoutes = () => (
    <Route path={RouteRegistry.ADMIN.DASHBOARD} element={<RequireRole allowedRoles={['admin']}><AppLayout /></RequireRole>}>
        <Route index element={<AdminDashboard />} />
        <Route path={RouteRegistry.ADMIN.SUMMARY_DASHBOARD} element={<RegistrySummaryDashboard />} />
        <Route path={RouteRegistry.ADMIN.USERS} element={<UserList />} />
        <Route path={RouteRegistry.ADMIN.USERS_NEW} element={<UserEntry />} />
        <Route path={RouteRegistry.ADMIN.USERS_EDIT(':id')} element={<UserEntry />} />
        <Route path={RouteRegistry.ADMIN.SCHEDULE} element={<Schedule />} />
        <Route path={RouteRegistry.ADMIN.EARNINGS} element={<AdminEarningsPage />} />
        <Route path={RouteRegistry.ADMIN.INCIDENTS} element={<IncidentList />} />
        <Route path={RouteRegistry.ADMIN.INCIDENTS_NEW} element={<IncidentEntry />} />
        <Route path={RouteRegistry.ADMIN.INCIDENTS_EDIT(':id')} element={<IncidentEntry />} />
        <Route path={RouteRegistry.ADMIN.TIMESHEETS} element={<Timesheets />} />
        <Route path={RouteRegistry.ADMIN.TIMESHEET_ADJUST} element={<TimesheetAdjustment />} />
        <Route path={RouteRegistry.ADMIN.LEADS} element={<LeadsPage />} />
        <Route path={RouteRegistry.ADMIN.LEADS_NEW} element={<LeadEntryForm />} />
        <Route path={RouteRegistry.ADMIN.LEADS_EDIT(':id')} element={<LeadEntryForm />} />
        <Route path={RouteRegistry.ADMIN.LEADS_CONVERT(':id')} element={<LeadConversion />} />
        <Route path={RouteRegistry.ADMIN.OPERATIONS.LOGISTICS_HUB} element={<LogisticsHub />} />
        <Route path={RouteRegistry.ADMIN.OPERATIONS.REGION_MAPPING} element={<RegionMapping />} />
        <Route path={RouteRegistry.ADMIN.OPERATIONS.REALTIME_CAPACITY} element={<RealtimeCapacity />} />
        <Route path={RouteRegistry.ADMIN.SERVICES} element={<Services />} />
        <Route path={RouteRegistry.ADMIN.SETTINGS} element={<Settings />} />
        <Route path={RouteRegistry.ADMIN.CONTENT} element={<ContentManager />} />
        <Route path={RouteRegistry.ADMIN.AUDITS} element={<AuditLogs />} />
        <Route path={RouteRegistry.ADMIN.ADMISSION} element={<LeadAdmission />} />
        <Route path={RouteRegistry.ADMIN.ONBOARDING} element={<Onboarding />} />
        <Route path={RouteRegistry.ADMIN.REPORTS} element={<ReportCenter />} />
        <Route path={RouteRegistry.ADMIN.INVOICES_NEW} element={<InvoicesNew />} />
        <Route path={RouteRegistry.ADMIN.INVOICES_EDIT(':id')} element={<InvoicesNew />} />
        <Route path={RouteRegistry.ADMIN.SETUP_WIZARD} element={<BusinessSetupWizard />} />
        <Route path={RouteRegistry.ADMIN.WIZARD_HUB} element={<WizardHub />} />
        <Route path={RouteRegistry.ADMIN.STAFF_ONBOARDING} element={<StaffOnboardingWizard />} />
        <Route path={RouteRegistry.ADMIN.CARE_PLAN_WIZARD} element={<CarePlanWizard />} />
        <Route path={RouteRegistry.ADMIN.REVENUE_WIZARD} element={<RevenueWizard />} />
        <Route path={RouteRegistry.ADMIN.BUSINESS_MODEL_WIZARD} element={<BusinessModelWizard />} />
        <Route path={RouteRegistry.ADMIN.BUSINESS_STATUS} element={<BusinessStatus />} />
        <Route path={RouteRegistry.ADMIN.CUSTOMERS} element={<AdminCustomerList />} />
        <Route path={RouteRegistry.ADMIN.TEMPLATE_EDITOR} element={<TemplateEditor />} />
        <Route path={RouteRegistry.ADMIN.SEARCH} element={<SearchPage />} />
        <Route path={RouteRegistry.ADMIN.REPORT_EXPORT} element={<ExportPage />} />
        <Route path={RouteRegistry.ADMIN.ERP.INVENTORY} element={<SupplyChainHub />} />
        <Route path={RouteRegistry.ADMIN.ERP.PROCUREMENT} element={<SupplyChainHub />} />
        <Route path={RouteRegistry.ADMIN.TELEHEALTH.CENTER} element={<TelehealthCenter />} />
        <Route path={RouteRegistry.ADMIN.TELEHEALTH.ALERTS} element={<TelehealthCenter />} />
        <Route path={RouteRegistry.ADMIN.RCM.CLAIMS} element={<RevenueCycleHub />} />
        <Route path={RouteRegistry.ADMIN.RCM.REVENUE} element={<RevenueCycleHub />} />
        <Route path={RouteRegistry.ADMIN.PHARMACY.HUB} element={<PharmacyHub />} />
        <Route path={RouteRegistry.ADMIN.PHARMACY.MAR} element={<PharmacyHub />} />
        <Route path={RouteRegistry.ADMIN.SECURITY.GOVERNANCE} element={<SecurityGovernance />} />
        <Route path={RouteRegistry.ADMIN.SECURITY.DEVICE_REGISTRY} element={<DeviceManagement />} />
    </Route>
);
