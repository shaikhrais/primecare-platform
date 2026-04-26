import 'package:primecare_ui/primecare_ui.dart';

/// The IT Security Dashboard Intent.
/// Defines the route, required roles, and telemetry provider for the Security HUD.
class ITSecurityDashboardIntent extends PrimeCareScreen {
  ITSecurityDashboardIntent()
    : super(
        name: 'it_security',
        title: 'IT Security HUD',
        subtitle: 'Cyber-Shield intelligence and threat-management console.',
        requiredRole: PlatformRole.admin,
        route: InfrastructureRoutes.securityDashboard,
        provider: itSecurityDashboardAdapterProvider,
      );

  @override
  String get structuralPlan =>
      'Cyber-Shield Intelligence HUD: Primary threat metrics in hero, block velocity charts, and automated lockdown controls.';

  @override
  List<String> get componentLabels => [
    'dashboards.itsecurity.labels.threat_hero',
    'dashboards.itsecurity.labels.block_velocity_chart',
    'dashboards.itsecurity.labels.lockdown_controls',
    'dashboards.itsecurity.labels.security_audit_trail',
  ];

  @override
  Widget build(BuildContext context) => const ITSecurityDashboardScreen();
}
