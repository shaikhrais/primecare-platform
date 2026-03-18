import React, { lazy } from 'react';
import { Route } from 'react-router';
import { AdminRegistry } from 'prime-care-shared';
import RequireRole from '@/shared/rbac/RequireRole';
import AppLayout from '@/shared/components/layout/AppLayout';

const { RouteRegistry } = AdminRegistry;

// Admin components (Dashboard eagerly loaded for instant first paint)
import { AdminDashboard } from './dashboard';

// Admin secondary pages (Lazy loaded)
const RegistrySummaryDashboard = lazy(() => import('./dashboard').then(m => ({ default: m.RegistrySummary })));
const UserList = lazy(() => import('./users').then(m => ({ default: m.UserList })));
const UserEntry = lazy(() => import('./users').then(m => ({ default: m.UserEntry })));
const AdminEarningsPage = lazy(() => import('./earnings'));

// Admin Pages (Lazy loaded)
const Schedule = lazy(() => import('./schedule').then(m => ({ default: m.Schedule })));
const IncidentList = lazy(() => import('./incidents').then(m => ({ default: m.IncidentList  })));
const IncidentEntry = lazy(() => import('./incidents').then(m => ({ default: m.IncidentEntry  })));
const LeadsPage = lazy(() => import('./leads').then(m => ({ default: m.LeadList  })));
const LeadEntryForm = lazy(() => import('./leads').then(m => ({ default: m.LeadEntryForm  })));
const LeadConversion = lazy(() => import('./leads').then(m => ({ default: m.LeadConversion  })));
const LogisticsHub = lazy(() => import('../../tenancy/admin/ops').then(m => ({ default: m.LogisticsHub  })));
const RegionMapping = lazy(() => import('../../tenancy/admin/ops').then(m => ({ default: m.RegionMapping  })));
const RealtimeCapacity = lazy(() => import('../../tenancy/admin/ops').then(m => ({ default: m.RealtimeCapacity  })));
const Timesheets = lazy(() => import('./timesheets').then(m => ({ default: Object.values(m)[0] as any })));
const TimesheetAdjustment = lazy(() => import('./timesheet-adjustment').then(m => ({ default: Object.values(m)[0] as any })));
const Services = lazy(() => import('./services').then(m => ({ default: Object.values(m)[0] as any })));
const Settings = lazy(() => import('./settings').then(m => ({ default: m.Settings })));
const ContentManager = lazy(() => import('./content').then(m => ({ default: m.ContentManager })));
const AuditLogs = lazy(() => import('./audits').then(m => ({ default: m.AuditLogs })));
const LeadAdmission = lazy(() => import('./admission').then(m => ({ default: m.ClientAdmission })));
const Onboarding = lazy(() => import('./onboarding').then(m => ({ default: m.StaffOnboarding })));
const ReportCenter = lazy(() => import('./reports').then(m => ({ default: m.ReportCenter })));
const InvoicesNew = lazy(() => import('./invoices').then(m => ({ default: m.InvoiceEntry })));
const BusinessSetupWizard = lazy(() => import('./setup').then(m => ({ default: m.BusinessSetupWizard })));
const WizardHub = lazy(() => import('./setup').then(m => ({ default: m.WizardHub })));
const StaffOnboardingWizard = lazy(() => import('./setup').then(m => ({ default: m.StaffOnboardingWizard })));
const CarePlanWizard = lazy(() => import('./setup').then(m => ({ default: m.CarePlanWizard })));
const RevenueWizard = lazy(() => import('./setup').then(m => ({ default: m.RevenueWizard })));
const BusinessModelWizard = lazy(() => import('./setup').then(m => ({ default: m.BusinessModelWizard })));
const BusinessStatus = lazy(() => import('./setup').then(m => ({ default: m.BusinessStatus })));
const KnowledgeBaseIndex = lazy(() => import('./knowledge-base').then(m => ({ default: m.KnowledgeBase })));
const KnowledgeBaseArticle = lazy(() => import('./knowledge-base').then(m => ({ default: m.KBArticle })));
const AIInsights = lazy(() => import('./insights').then(m => ({ default: m.AiInsights })));
const ClinicalAssistant = lazy(() => import('./clinical-assistant').then(m => ({ default: m.ClinicalAssistant })));
const AutoPilotDashboard = lazy(() => import('./automation').then(m => ({ default: Object.values(m)[0] as any })));
const FHIRCenter = lazy(() => import('./interoperability').then(m => ({ default: Object.values(m)[0] as any })));
const SovereignWallet = lazy(() => import('./sovereign').then(m => ({ default: Object.values(m)[0] as any })));
const Locations = lazy(() => import('./locations'));
const RoleEditor = lazy(() => import('./role-editor').then(m => ({ default: m.RoleEditor })));
const AdminCustomerList = lazy(() => import('./customers').then(m => ({ default: m.CustomerList })));
const TemplateEditor = lazy(() => import('./template-editor').then(m => ({ default: m.TemplateEditor })));
const SearchPage = lazy(() => import('./search').then(m => ({ default: Object.values(m)[0] as any })));
const ExportPage = lazy(() => import('./reports').then(m => ({ default: m.ExportPage })));
const SupplyChainHub = lazy(() => import('./erp').then(m => ({ default: Object.values(m)[0] as any })));
const TelehealthCenter = lazy(() => import('./telehealth').then(m => ({ default: Object.values(m)[0] as any })));
const RevenueCycleHub = lazy(() => import('./rcm').then(m => ({ default: Object.values(m)[0] as any })));
const PharmacyHub = lazy(() => import('./pharmacy').then(m => ({ default: Object.values(m)[0] as any })));
const SecurityGovernance = lazy(() => import('./security').then(m => ({ default: m.SecurityGovernance })));
const DeviceManagement = lazy(() => import('./security').then(m => ({ default: m.DeviceManagement })));
const ForensicTrails = lazy(() => import('./security').then(m => ({ default: m.ForensicTrails })));
const CorsSettings = lazy(() => import('./security').then(m => ({ default: m.CorsSettings })));
const IntegrityVerification = lazy(() => import('./security').then(m => ({ default: m.IntegrityVerification })));
const FinancialLedger = lazy(() => import('./security').then(m => ({ default: m.FinancialLedger })));
const TaxComplianceHub = lazy(() => import('./security').then(m => ({ default: m.TaxComplianceHub })));
const AccountingDashboard = lazy(() => import('./security').then(m => ({ default: m.AccountingDashboard })));
const FinancialReconciliation = lazy(() => import('./finance/reconciliation').then(m => ({ default: m.FinancialReconciliation })));
const NotificationsHub = lazy(() => import('./notifications').then(m => ({ default: Object.values(m)[0] as any })));
const DocumentCenter = lazy(() => import('./documents').then(m => ({ default: Object.values(m)[0] as any })));
const PayrollHub = lazy(() => import('./payroll').then(m => ({ default: Object.values(m)[0] as any })));
const BookingRequestQueue = lazy(() => import('./booking-requests').then(m => ({ default: Object.values(m)[0] as any })));
const ReferenceDataHub = lazy(() => import('./reference-data').then(m => ({ default: Object.values(m)[0] as any })));
const CronDashboard = lazy(() => import('./cron').then(m => ({ default: Object.values(m)[0] as any })));
const FormRegistryPage = lazy(() => import('./form-registry')); // G1
const PageRegistryPage = lazy(() => import('./page-registry')); // G2

const EvvDashboard = lazy(() => import('./evv').then(m => ({ default: m.EvvDashboard })));
const EvvExceptions = lazy(() => import('./evv').then(m => ({ default: m.EvvExceptions })));
const EvvExport = lazy(() => import('./evv').then(m => ({ default: m.EvvExport })));
const AuthList = lazy(() => import('./authorizations').then(m => ({ default: m.AuthList })));
const AuthAlerts = lazy(() => import('./authorizations').then(m => ({ default: m.AuthAlerts })));
const AuthUtilization = lazy(() => import('./authorizations').then(m => ({ default: m.AuthUtilization })));
const ConsentList = lazy(() => import('./consent').then(m => ({ default: m.ConsentList })));
const ConsentTemplates = lazy(() => import('./consent').then(m => ({ default: m.ConsentTemplates })));
const ConsentExpiring = lazy(() => import('./consent').then(m => ({ default: m.ConsentExpiring })));
const ReferralList = lazy(() => import('./referrals').then(m => ({ default: m.ReferralList })));
const ReferralAnalytics = lazy(() => import('./referrals').then(m => ({ default: m.ReferralAnalytics })));
const ClaimsList = lazy(() => import('./claims').then(m => ({ default: m.ClaimsList })));
const ClaimsEra = lazy(() => import('./claims').then(m => ({ default: m.ClaimsEra })));
const WebhookList = lazy(() => import('./webhooks').then(m => ({ default: m.WebhookList })));
const WebhookDeliveries = lazy(() => import('./webhooks').then(m => ({ default: m.WebhookDeliveries })));
const AuditDownload = lazy(() => import('./audit-export').then(m => ({ default: m.AuditDownload })));
const ComplianceExport = lazy(() => import('./audit-export').then(m => ({ default: m.ComplianceExport })));
const RegulatoryExport = lazy(() => import('./audit-export').then(m => ({ default: m.RegulatoryExport })));
const AiDashboard = lazy(() => import('./ai').then(m => ({ default: m.AiDashboard })));
const PredictiveAnalytics = lazy(() => import('./ai').then(m => ({ default: m.PredictiveAnalytics })));
const ChurnRisk = lazy(() => import('./ai').then(m => ({ default: m.ChurnRisk })));
const VisitOptimization = lazy(() => import('./ai').then(m => ({ default: m.VisitOptimization })));
const SentimentAnalysis = lazy(() => import('./ai').then(m => ({ default: m.SentimentAnalysis })));
const PermissionGrid = lazy(() => import('./security').then(m => ({ default: m.PermissionGrid })));
const SessionMonitor = lazy(() => import('./security').then(m => ({ default: m.SessionMonitor })));
const ThreatDetection = lazy(() => import('./security').then(m => ({ default: m.ThreatDetection })));
const OperationsCenter = lazy(() => import('./ops').then(m => ({ default: m.OperationsCenter })));
const SupplyDemand = lazy(() => import('./ops').then(m => ({ default: m.SupplyDemand })));

// NEW PREMIUM PAGES (Session Sprint 3-6)
const AICommandCenter = lazy(() => import('./ai').then(m => ({ default: m.AICommandCenter })));
const MultiCurrencySettings = lazy(() => import('./settings').then(m => ({ default: m.MultiCurrencySettings })));
const AuditTrailViewer = lazy(() => import('./security').then(m => ({ default: m.AuditTrailViewer })));
const FranchiseManagement = lazy(() => import('./franchise').then(m => ({ default: Object.values(m)[0] as any })));
const SupplyChainManagement = lazy(() => import('./supply-chain').then(m => ({ default: Object.values(m)[0] as any })));

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
        <Route path={RouteRegistry.ADMIN.OPERATIONS.CENTER} element={<OperationsCenter />} />
        <Route path={RouteRegistry.ADMIN.OPERATIONS.SUPPLY_DEMAND} element={<SupplyDemand />} />
        {/* NEW PREMIUM PAGES */}
        <Route path={RouteRegistry.ADMIN.AI_COMMAND} element={<AICommandCenter />} />
        <Route path={RouteRegistry.ADMIN.MULTI_CURRENCY} element={<MultiCurrencySettings />} />
        <Route path={RouteRegistry.ADMIN.AUDIT_TRAIL} element={<AuditTrailViewer />} />
        <Route path={RouteRegistry.ADMIN.FRANCHISE} element={<FranchiseManagement />} />
        <Route path={RouteRegistry.ADMIN.SUPPLY_CHAIN} element={<SupplyChainManagement />} />
    </Route>
);
