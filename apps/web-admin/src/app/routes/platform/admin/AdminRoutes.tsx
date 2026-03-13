import React, { lazy } from 'react';
import { Route } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import RequireRole from '@/shared/rbac/RequireRole';
import AppLayout from '@/shared/components/layout/AppLayout';

const { RouteRegistry } = AdminRegistry;

// Admin components (Eagerly loaded to avoid layout shifts on dashboard)
import AdminDashboard from './pages/dashboard';
import RegistrySummaryDashboard from './pages/dashboard/D2-RegistrySummary';
import { UserList, UserEntry } from './pages/users';
import AdminEarningsPage from './pages/earnings';

// Admin Pages (Lazy loaded)
const Schedule = lazy(() => import('./pages/schedule'));
const IncidentList = lazy(() => import('./pages/incidents/L2-IncidentList'));
const IncidentEntry = lazy(() => import('./pages/incidents').then(m => ({ default: m.IncidentEntry })));
const LeadsPage = lazy(() => import('./pages/leads').then(m => ({ default: m.LeadsPage })));
const LeadEntryForm = lazy(() => import('./pages/leads').then(m => ({ default: m.LeadEntryForm })));
const LeadConversion = lazy(() => import('./pages/leads').then(m => ({ default: m.LeadConversion })));
const LogisticsHub = lazy(() => import('../../tenancy/admin/pages/ops/LogisticsHub')); // H10-LogisticsHub
const RegionMapping = lazy(() => import('../../tenancy/admin/pages/ops/RegionMapping'));
const RealtimeCapacity = lazy(() => import('../../tenancy/admin/pages/ops/RealtimeCapacity'));
const Timesheets = lazy(() => import('./pages/timesheets/L4-Timesheets'));
const TimesheetAdjustment = lazy(() => import('./pages/timesheet-adjustment'));
const Services = lazy(() => import('./pages/services/L5-Services'));
const Settings = lazy(() => import('./pages/settings'));
const ContentManager = lazy(() => import('./pages/content/T2-ContentManager'));
const AuditLogs = lazy(() => import('./pages/audits/L6-AuditLogs'));
const LeadAdmission = lazy(() => import('./pages/admission'));
const Onboarding = lazy(() => import('./pages/onboarding'));
const ReportCenter = lazy(() => import('./pages/reports/R1-ReportCenter'));
const InvoicesNew = lazy(() => import('./pages/invoices').then(m => ({ default: m.InvoiceEntry })));
const BusinessSetupWizard = lazy(() => import('./pages/setup/W1-BusinessSetupWizard'));
const WizardHub = lazy(() => import('./pages/setup/WizardHub'));
const StaffOnboardingWizard = lazy(() => import('./pages/setup/W2-StaffOnboardingWizard'));
const CarePlanWizard = lazy(() => import('./pages/setup/W3-CarePlanWizard'));
const RevenueWizard = lazy(() => import('./pages/setup/W4-RevenueWizard'));
const BusinessModelWizard = lazy(() => import('./pages/setup/W5-BusinessModelWizard'));
const BusinessStatus = lazy(() => import('./pages/setup/BusinessStatus'));
const KnowledgeBaseIndex = lazy(() => import('./pages/knowledge-base/H8-KnowledgeBase'));
const KnowledgeBaseArticle = lazy(() => import('./pages/knowledge-base/KnowledgeBaseArticle'));
const AIInsights = lazy(() => import('./pages/insights/T9-AiInsights'));
const ClinicalAssistant = lazy(() => import('./pages/clinical-assistant/T8-ClinicalAssistant'));
const AutoPilotDashboard = lazy(() => import('./pages/automation/T7-AutoPilot'));
const FHIRCenter = lazy(() => import('./pages/interoperability/T5-FHIRCenter'));
const SovereignWallet = lazy(() => import('./pages/sovereign/T6-SovereignWallet'));
const Locations = lazy(() => import('./pages/locations'));
const RoleEditor = lazy(() => import('./pages/role-editor/T4-RoleEditor'));
const AdminCustomerList = lazy(() => import('./pages/customers/L15-CustomerList'));
const TemplateEditor = lazy(() => import('./pages/template-editor/T3-TemplateEditor'));
const SearchPage = lazy(() => import('./pages/search/T1-SearchPage'));
const ExportPage = lazy(() => import('./pages/reports/R2-ExportPage'));
const SupplyChainHub = lazy(() => import('./pages/erp/H4-SupplyChainHub'));
const TelehealthCenter = lazy(() => import('./pages/telehealth/H1-TelehealthCenter'));
const RevenueCycleHub = lazy(() => import('./pages/rcm/H3-RevenueCycleHub'));
const PharmacyHub = lazy(() => import('./pages/pharmacy/H2-PharmacyHub'));
const SecurityGovernance = lazy(() => import('./pages/security/T10-SecurityGovernance'));
const DeviceManagement = lazy(() => import('./pages/security/T13-DeviceManagement'));
const ForensicTrails = lazy(() => import('./pages/security/T14-ForensicTrails'));
const CorsSettings = lazy(() => import('./pages/security/T15-CorsSettings'));
const IntegrityVerification = lazy(() => import('./pages/security/T16-IntegrityVerification'));
const FinancialLedger = lazy(() => import('./pages/security/T17-FinancialLedger'));
const TaxComplianceHub = lazy(() => import('./pages/security/T18-TaxComplianceHub'));
const AccountingDashboard = lazy(() => import('./pages/security/D3-AccountingDashboard'));
const FinancialReconciliation = lazy(() => import('./pages/finance/reconciliation'));
const NotificationsHub = lazy(() => import('./pages/notifications/H5-NotificationsHub'));
const DocumentCenter = lazy(() => import('./pages/documents/H6-DocumentCenter'));
const PayrollHub = lazy(() => import('./pages/payroll/H7-PayrollHub'));
const BookingRequestQueue = lazy(() => import('./pages/booking-requests/L12-BookingRequestQueue'));
const ReferenceDataHub = lazy(() => import('./pages/reference-data/H9-ReferenceDataHub'));
const CronDashboard = lazy(() => import('./pages/cron/D6-CronDashboard'));
const FormRegistryPage = lazy(() => import('./pages/form-registry'));
const PageRegistryPage = lazy(() => import('./pages/page-registry'));

const EvvDashboard = lazy(() => import('./pages/evv/D4-EvvDashboard'));
const EvvExceptions = lazy(() => import('./pages/evv/EvvExceptions'));
const EvvExport = lazy(() => import('./pages/evv/R8-EvvExport'));
const AuthList = lazy(() => import('./pages/authorizations/L7-AuthList'));
const AuthAlerts = lazy(() => import('./pages/authorizations/AuthAlerts'));
const AuthUtilization = lazy(() => import('./pages/authorizations/AuthUtilization'));
const ConsentList = lazy(() => import('./pages/consent/L8-ConsentList'));
const ConsentTemplates = lazy(() => import('./pages/consent/ConsentTemplates'));
const ConsentExpiring = lazy(() => import('./pages/consent/ConsentExpiring'));
const ReferralList = lazy(() => import('./pages/referrals/L9-ReferralList'));
const ReferralAnalytics = lazy(() => import('./pages/referrals/R11-ReferralAnalytics'));
const ClaimsList = lazy(() => import('./pages/claims/L10-ClaimsList'));
const ClaimsEra = lazy(() => import('./pages/claims/R12-ClaimsEra'));
const WebhookList = lazy(() => import('./pages/webhooks/L11-WebhookList'));
const WebhookDeliveries = lazy(() => import('./pages/webhooks/WebhookDeliveries'));
const AuditDownload = lazy(() => import('./pages/audit-export/R9-AuditDownload'));
const ComplianceExport = lazy(() => import('./pages/audit-export/R10-ComplianceExport'));
const RegulatoryExport = lazy(() => import('./pages/audit-export/RegulatoryExport'));
const AiDashboard = lazy(() => import('./pages/ai/D5-AiDashboard'));
const PredictiveAnalytics = lazy(() => import('./pages/ai/PredictiveAnalytics'));
const ChurnRisk = lazy(() => import('./pages/ai/ChurnRisk'));
const VisitOptimization = lazy(() => import('./pages/ai/VisitOptimization'));
const SentimentAnalysis = lazy(() => import('./pages/ai/SentimentAnalysis'));
const PermissionGrid = lazy(() => import('./pages/security/PermissionGrid'));
const SessionMonitor = lazy(() => import('./pages/security/SessionMonitor'));
const ThreatDetection = lazy(() => import('./pages/security/ThreatDetection'));
const SupplyDemand = lazy(() => import('./pages/ops/SupplyDemand'));

export const AdminRoutes = () => (
    <Route path={RouteRegistry.ADMIN.DASHBOARD} element={<RequireRole allowedRoles={['admin', 'finance_director']}><AppLayout /></RequireRole>}>
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
        <Route path={RouteRegistry.ADMIN.SECURITY.FORENSIC_TRAILS} element={<ForensicTrails />} />
        <Route path={RouteRegistry.ADMIN.SECURITY.CORS_SETTINGS} element={<CorsSettings />} />
        <Route path={RouteRegistry.ADMIN.SECURITY.INTEGRITY_SCAN} element={<IntegrityVerification />} />
        <Route path={RouteRegistry.ADMIN.SECURITY.FINANCIAL_LEDGER} element={<FinancialLedger />} />
        <Route path={RouteRegistry.ADMIN.SECURITY.TAX_HUB} element={<TaxComplianceHub />} />
        <Route path={RouteRegistry.ADMIN.FINANCE.DASHBOARD} element={<AccountingDashboard />} />
        <Route path={RouteRegistry.ADMIN.FINANCE.RECONCILIATION} element={<FinancialReconciliation />} />
        <Route path={RouteRegistry.ADMIN.NOTIFICATIONS_HUB} element={<NotificationsHub />} />
        <Route path={RouteRegistry.ADMIN.DOCUMENT_CENTER} element={<DocumentCenter />} />
        <Route path={RouteRegistry.ADMIN.PAYROLL_HUB} element={<PayrollHub />} />
        <Route path={RouteRegistry.ADMIN.BOOKING_REQUESTS} element={<BookingRequestQueue />} />
        <Route path={RouteRegistry.ADMIN.REFERENCE_DATA} element={<ReferenceDataHub />} />
        <Route path={RouteRegistry.ADMIN.CRON_DASHBOARD} element={<CronDashboard />} />
        <Route path={RouteRegistry.ADMIN.FORM_REGISTRY} element={<FormRegistryPage />} />
        <Route path={RouteRegistry.ADMIN.PAGE_REGISTRY} element={<PageRegistryPage />} />
            <Route path={RouteRegistry.ADMIN.EVV.DASHBOARD} element={<EvvDashboard />} />
        <Route path={RouteRegistry.ADMIN.EVV.EXCEPTIONS} element={<EvvExceptions />} />
        <Route path={RouteRegistry.ADMIN.EVV.EXPORT} element={<EvvExport />} />
        <Route path={RouteRegistry.ADMIN.AUTHORIZATIONS.LIST} element={<AuthList />} />
        <Route path={RouteRegistry.ADMIN.AUTHORIZATIONS.ALERTS} element={<AuthAlerts />} />
        <Route path={RouteRegistry.ADMIN.AUTHORIZATIONS.UTILIZATION(':clientId')} element={<AuthUtilization />} />
        <Route path={RouteRegistry.ADMIN.CONSENT.LIST} element={<ConsentList />} />
        <Route path={RouteRegistry.ADMIN.CONSENT.TEMPLATES} element={<ConsentTemplates />} />
        <Route path={RouteRegistry.ADMIN.CONSENT.EXPIRING} element={<ConsentExpiring />} />
        <Route path={RouteRegistry.ADMIN.REFERRALS.LIST} element={<ReferralList />} />
        <Route path={RouteRegistry.ADMIN.REFERRALS.ANALYTICS} element={<ReferralAnalytics />} />
        <Route path={RouteRegistry.ADMIN.CLAIMS.LIST} element={<ClaimsList />} />
        <Route path={RouteRegistry.ADMIN.CLAIMS.ERA} element={<ClaimsEra />} />
        <Route path={RouteRegistry.ADMIN.WEBHOOKS.LIST} element={<WebhookList />} />
        <Route path={RouteRegistry.ADMIN.WEBHOOKS.DELIVERIES} element={<WebhookDeliveries />} />
        <Route path={RouteRegistry.ADMIN.AUDIT_EXPORT.DOWNLOAD} element={<AuditDownload />} />
        <Route path={RouteRegistry.ADMIN.AUDIT_EXPORT.COMPLIANCE} element={<ComplianceExport />} />
        <Route path={RouteRegistry.ADMIN.AUDIT_EXPORT.REGULATORY} element={<RegulatoryExport />} />
        <Route path={RouteRegistry.ADMIN.AI.DASHBOARD} element={<AiDashboard />} />
        <Route path={RouteRegistry.ADMIN.AI.PREDICTIVE_ANALYTICS} element={<PredictiveAnalytics />} />
        <Route path={RouteRegistry.ADMIN.AI.CHURN_RISK} element={<ChurnRisk />} />
        <Route path={RouteRegistry.ADMIN.AI.VISIT_OPTIMIZATION} element={<VisitOptimization />} />
        <Route path={RouteRegistry.ADMIN.AI.SENTIMENT_ANALYSIS} element={<SentimentAnalysis />} />
        <Route path={RouteRegistry.ADMIN.SECURITY.PERMISSION_GRID} element={<PermissionGrid />} />
        <Route path={RouteRegistry.ADMIN.SECURITY.SESSION_MONITOR} element={<SessionMonitor />} />
        <Route path={RouteRegistry.ADMIN.SECURITY.THREAT_DETECTION} element={<ThreatDetection />} />
        <Route path={RouteRegistry.ADMIN.OPERATIONS.SUPPLY_DEMAND} element={<SupplyDemand />} />
    </Route>
);
