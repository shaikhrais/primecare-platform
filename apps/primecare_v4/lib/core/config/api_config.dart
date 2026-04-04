import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Centralized Integration Layer defining exact Backend routing addresses.
class ApiConfig {
  /// Base API destination URL (e.g. gateway edge proxy)
  static String get baseUrl => dotenv.env['API_URL'] ?? 'https://primecare-api-gateway.itpro-mohammed.workers.dev';
  
  /// Global Semantic Versioning flag injected natively into the uri strings
  static const String version = 'v1';

  /// Immutable dictionary mapping the physical endpoints.
  /// If the backend changes a routing path, you ONLY update this value here.
  static const Map<String, String> endpoints = {
    'officeFranchisePipelineView': '/v1/primecare/office/franchise_pipeline',
    'officePartnerManagementView': '/v1/primecare/office/partner_management',
    'officeTerritoryTrackingView': '/v1/primecare/office/territory_tracking',
    'officeBookAppointmentView': '/v1/primecare/office/book_appointment',
    'officeCareLogsView': '/v1/primecare/office/care_logs',
    'officeCareTeamView': '/v1/primecare/office/care_team',
    'officeClientDashboard': '/v1/primecare/office/client',
    'officePaymentsView': '/v1/primecare/office/payments',
    'officeViewScheduleView': '/v1/primecare/office/view_schedule',
    'officeCareUpdatesView': '/v1/primecare/office/care_updates',
    'officeLinkedAccountsView': '/v1/primecare/office/linked_accounts',
    'officeTreatmentNotesView': '/v1/primecare/office/treatment_notes',
    'officeCarePlansView': '/v1/primecare/office/care_plans',
    'officeRpnNotesView': '/v1/primecare/office/rpn_notes',
    'officeCeoSettingsView': '/v1/primecare/office/ceo_settings',
    'officeFinancialOverviewView': '/v1/primecare/office/financial_overview',
    'officeComplianceTrackingView': '/v1/primecare/office/compliance_tracking',
    'officeOperationsOverviewView': '/v1/primecare/office/operations_overview',
    'officeOpsEfficiencyView': '/v1/primecare/office/ops_efficiency',
    'officeSystemArchitectView': '/v1/primecare/office/system_architect',
    'officeSystemSettingsView': '/v1/primecare/office/system_settings',
    'officeInvoicesView': '/v1/primecare/office/invoices',
    'officeInvoiceGenerationView': '/v1/primecare/office/invoice_generation',
    'officeDailyOperationsView': '/v1/primecare/office/daily_operations',
    'officePartnershipLeadsView': '/v1/primecare/office/partnership_leads',
    'officePipelineView': '/v1/primecare/office/pipeline',
    'officeDocumentVaultScreen': '/v1/primecare/office/document_vault_screen',
    'officeGlobalProfileScreen': '/v1/primecare/office/global_profile_screen',
    'officeGlobalSettingsScreen': '/v1/primecare/office/global_settings_screen',
    'officeMessagingHubScreen': '/v1/primecare/office/messaging_hub_screen',
    'officeNotificationCenterScreen': '/v1/primecare/office/notification_center_screen',

    'login': '/auth/login',
    'register': '/auth/register',
    
    'providerDashboard': '/providers/profile/me',
    'providerMetrics': '/dashboard/metrics',
    'providerCheckin': '/visits/:visitId/checkin',
    
    'intakeCases': '/intake/cases',
    'carePlansUpdate': '/care-plans/update',
    'trainingComplete': '/training/complete',
    'supportEscalate': '/support/tickets/escalate',
    'franchiseTerritoryUpdate': '/franchise/territory/update',
    'reportingSummary': '/reporting/summary',
  };
}
