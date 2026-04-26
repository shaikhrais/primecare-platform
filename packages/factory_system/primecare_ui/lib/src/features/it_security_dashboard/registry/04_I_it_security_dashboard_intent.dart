import 'package:primecare_ui/primecare_ui.dart';

/// The IT Security Dashboard Intent.
/// Defines the route, required roles, and telemetry provider for the Security HUD.
class ITSecurityDashboardIntent extends PrimeCareScreen {
  ITSecurityDashboardIntent()
    : super(
        name: 'it_security',
        title: LocaleKeys.dashboards_common_labels_it_security_hud.tr(),
        subtitle: LocaleKeys
            .dashboards_common_labels_cyber_shield_intelligence_and_threat_management_console
            .tr(),
        requiredRole: PlatformRole.admin,
        route: InfrastructureRoutes.securityDashboard,
        provider: itSecurityDashboardAdapterProvider,
      );

  @override
  String get structuralPlan =>
      'Cyber-Shield Intelligence HUD: Primary threat metrics in hero, block velocity charts, and automated lockdown controls.';

  @override
  List<String> get componentLabels => [
    'dashboards.itsecurity.labels.dashboards_itsecurity_labels_threat_hero',
    'dashboards.itsecurity.labels.dashboards_itsecurity_labels_block_velocity_chart',
    'dashboards.itsecurity.labels.dashboards_itsecurity_labels_lockdown_controls',
    'dashboards.itsecurity.labels.dashboards_itsecurity_labels_security_audit_trail',
  ];

  @override
  Widget build(BuildContext context) => const ITSecurityDashboardScreen();
}
