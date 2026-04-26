import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_shareholder_intelligence_screen.dart';

/// The governed intent for the Shareholder Intelligence Dashboard.
/// Provides executives with real-time telemetry, pipeline stages, and zero-error verification metrics.
class ShareholderIntelligenceDashboardIntent extends AppScreenIntent {
  const ShareholderIntelligenceDashboardIntent();

  @override
  String get name => 'shareholder_intelligence_dashboard';

  @override
  String get title => 'dashboards.shareholderintelligence.title';

  @override
  String get subtitle => 'Real-time Telemetry & Governance Pipeline';

  @override
  PlatformRole? get requiredRole => PlatformRole.shareholder;

  // Uses the specific adapter for Shareholder Intelligence
  @override
  dynamic get provider => shareholderIntelligenceAdapterProvider;

  @override
  PlatformSubsystem? get primarySubsystem => PlatformSubsystem.metrics;

  @override
  ResiliencePolicy get resiliencePolicy => const ResiliencePolicy(
    strategy: ScreenRecoveryStrategy.fallbackRedirect,
    fallbackRoute: '/corporate/error-fallback',
  );

  @override
  List<String> get componentLabels => [
    'dashboards.shareholderintelligence.labels.dashboards_shareholderintelligence_labels_global_governance_header',
    'dashboards.shareholderintelligence.labels.dashboards_shareholderintelligence_labels_feature_pipeline_kanban',
    'dashboards.shareholderintelligence.labels.dashboards_shareholderintelligence_labels_real_time_telemetry_feed',
    'dashboards.shareholderintelligence.labels.dashboards_shareholderintelligence_labels_shareholder_roi_matrix',
    'dashboards.shareholderintelligence.labels.dashboards_shareholderintelligence_labels_feature_request_fab',
  ];

  @override
  Widget build(BuildContext context) {
    // Falls back to globalRenderer if defined, otherwise renders the screen natively
    return AppScreenIntent.globalRenderer?.call(context, this) ??
        const ShareholderIntelligenceScreen();
  }
}
