// Layer: 01_INFRASTRUCTURE
class AdminRoutes {
  const AdminRoutes._();

  static const String adminDashboard = '/infrastructure/admin/dashboard';
  static const String systemDashboard = '/infrastructure/system/dashboard';
  static const String scrumMasterDashboard =
      '/infrastructure/admin/scrum-master';
}

class InfrastructureRoutes {
  const InfrastructureRoutes._();

  static const String healthDashboard = '/infrastructure/health';
  static const String systemDashboard = '/infrastructure/system/dashboard';
  static const String configurationDashboard = '/infrastructure/config';
  static const String securityDashboard = '/infrastructure/security';
  static const String systemVerification =
      '/infrastructure/system/verification';
  static const String governanceMonitor = '/infrastructure/governance/monitor';
}
