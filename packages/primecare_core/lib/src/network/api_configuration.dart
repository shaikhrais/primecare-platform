/// Shared API aliases and deterministic base-URL selection.
class ApiConfiguration {
  static String resolveBaseUrl({
    required bool isWeb,
    String configured = const String.fromEnvironment('API_BASE_URL'),
  }) {
    if (configured.isNotEmpty) return configured;
    if (isWeb) return '';
    return 'https://primecare-api-gateway.itpro-mohammed.workers.dev';
  }

  static const Map<String, String> endpoints = {
    'login': '/v1/auth/login',
    'register': '/v1/auth/register',
    'forgotPassword': '/v1/auth/forgot-password',
    'resetPassword': '/v1/auth/reset-password',
    'me': '/v1/auth/me',
    'dashboard-metrics': '/v1/governance/dashboard',
    'providerProfile': '/v1/provider/profile',
    'providerDashboard': '/v1/provider/profile',
    'providerCheckin': '/v1/provider/checkin',
    'verificationPurposeReport': '/v1/verification/purpose-report',
    'verificationDatabaseReport': '/v1/verification/database-report',
    'systemPermissions': '/v1/system/permissions',
    'adminStaffProvision': '/v1/admin/staff-provision',
    'adminAuditOverride': '/v1/admin/audit-override',
    'officePartnershipLeadsView': '/v1/office/partnership-leads',
    'providerMetrics': '/v1/provider/metrics',
  };
}
