import 'package:primecare_ui/primecare_ui.dart';

/// The high-fidelity intent for the CTO Command Horizon.
/// This intent specifically targets the Obsidian Lens aesthetic and handles its own build logic.
class CtoDashboardIntent extends PrimeCareScreen {
  CtoDashboardIntent()
    : super(
        name: 'cto',
        title: LocaleKeys.dashboards_common_labels_systems___architecture.tr(),
        subtitle: LocaleKeys
            .dashboards_common_labels_infrastructure_health_and_api_performance_monitoring
            .tr(),
        requiredRole: PlatformRole.cto,
        provider: ctoDashboardAdapterProvider,
        route: CorporateRoutes.ctoDashboard,
        componentLabels: [
          'Command Horizon Header',
          'Briefing Panel',
          'System Health Cards',
          'Security Audit Log',
          'Architectural Load',
        ],
      );

  @override
  Widget build(BuildContext context) => const CtoDashboardScreen();
}
