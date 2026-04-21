// Layer: 01_INFRASTRUCTURE
/// Centralized configuration for the PrimeCare API.
class ApiConfig {
  /// The production-ready base URL for the Cloudflare Worker API.
  static const String baseUrl = 'https://primecare-verification-service.itpro-mohammed.workers.dev';
  
  /// Current API version segment.
  static const String version = 'v4';

  /// Standardized timeout for most operations.
  static const Duration timeout = Duration(seconds: 15);

  /// Standardized API endpoints mapping.
  static const Map<String, String> endpoints = {
    'login': '/v1/auth/login',
    'register': '/v1/auth/register',
    'verify': '/v1/auth/verify',
    'refresh': '/v1/auth/refresh',
    'telemetry': '/v1/telemetry',
    'events': '/v1/events',
    'intakeCases': '/v1/intake/cases',
    'carePlansUpdate': '/v1/clinical/care-plans/update',
    'trainingDirectorView': '/v1/clinical/training/director-view',
    'trainingComplete': '/v1/clinical/training/complete',
    'supportEscalate': '/v1/support/tickets/escalate',
    'franchiseTerritoryUpdate': '/v1/franchise/territory/update',
    'reportingSummary': '/v1/reporting/summary',
    'adminStaffProvision': '/v1/admin/staff/provision',
    'adminAuditOverride': '/v1/admin/audit/override',
    'officePartnershipLeadsView': '/v1/office/partnership/leads',
    'trainingCoordinatorDashboard': '/v1/training-coordinator/dashboard',
    'providerMetrics': '/v1/provider/metrics',
  };
}
