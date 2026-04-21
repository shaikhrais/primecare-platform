// Layer: 01_INFRASTRUCTURE
/// Centralized configuration for the PrimeCare API.
class ApiConfig {
  /// The production-ready base URL for the Cloudflare Worker API.
  static const String baseUrl = 'https://worker-api.primecare.workers.dev';
  
  /// Current API version segment.
  static const String version = 'v4';

  /// Standardized timeout for most operations.
  static const Duration timeout = Duration(seconds: 15);

  /// Standardized API endpoints mapping.
  static const Map<String, String> endpoints = {
    'login': '/api/v1/auth/login',
    'register': '/api/v1/auth/register',
    'verify': '/api/v1/auth/verify',
    'refresh': '/api/v1/auth/refresh',
    'telemetry': '/api/v1/telemetry',
    'events': '/api/v1/events',
    'intakeCases': '/api/v1/intake/cases',
    'carePlansUpdate': '/api/v1/clinical/care-plans/update',
    'trainingDirectorView': '/api/v1/clinical/training/director-view',
    'trainingComplete': '/api/v1/clinical/training/complete',
    'supportEscalate': '/api/v1/support/tickets/escalate',
    'franchiseTerritoryUpdate': '/api/v1/franchise/territory/update',
    'reportingSummary': '/api/v1/reporting/summary',
    'adminStaffProvision': '/api/v1/admin/staff/provision',
    'adminAuditOverride': '/api/v1/admin/audit/override',
    'officePartnershipLeadsView': '/api/v1/office/partnership/leads',
    'trainingCoordinatorDashboard': '/api/v1/training-coordinator/dashboard',
    'providerMetrics': '/api/v1/provider/metrics',
  };
}
