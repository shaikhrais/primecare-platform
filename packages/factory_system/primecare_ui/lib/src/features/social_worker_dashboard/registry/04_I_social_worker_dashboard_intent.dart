// Layer: 04_REGISTRY_INTENT
import 'package:primecare_ui/primecare_ui.dart';
import '../presentation/widgets/05_U_social_worker_dashboard_screen.dart';

/// High-fidelity screen intent for the Social Worker.
/// Enforces the 'Social Care Command HUD' structural blueprint.
class SocialWorkerDashboardIntent extends PrimeCareScreen {
  SocialWorkerDashboardIntent()
    : super(
        name: 'social_worker_dashboard',
        title: 'Social Care Command HUD',
        subtitle:
            'Caseload Tracking, Crisis Intervention & Community Alignment',
        route: ClinicalRoutes.socialWorkerDashboard,
        requiredRole: PlatformRole.socialWorker,
        provider: socialWorkerMetricsProvider,
        componentLabels: [
          'Aura HUD',
          'Caseload Pulse Node',
          'Intervention Stability Vector',
          'Aura Social Node',
          'Social Event Ledger',
          'Command Row',
        ],
        structuralPlan: '''
[PrimeCareScaffold]
  - [AuraDashboardHud]: Global Social Care Health & Compliance Integrity
  - [Command Row]: Add Client, Crisis Override, Community Map, Escalate Case
  - [ResponsiveKpiGrid]: Active Caseload, Crisis Velocity, Intervention Rate, Community Linkage
  - [Intervention Stability Vector]: Visual trend of psychosocial interventions over time
  - [Aura Social Node]: AI insights on crisis detection and community resource availability
  - [Social Event Ledger]: Real-time feed of patient interactions and community linkage events
''',
      );

  @override
  Widget build(BuildContext context) => const SocialWorkerDashboardScreen();
}
