// Layer: 01_INFRASTRUCTURE
class AdminRoutes {
  const AdminRoutes._();

  static const String adminDashboard = '/infrastructure/admin/dashboard';
  static const String systemDashboard = '/infrastructure/system/dashboard';
}

class InfrastructureRoutes {
  const InfrastructureRoutes._();

  static const String healthDashboard = '/infrastructure/health';
  static const String systemDashboard = '/infrastructure/system/dashboard';
  static const String configurationDashboard = '/infrastructure/config';
}
