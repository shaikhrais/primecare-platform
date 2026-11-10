import 'package:flutter_core/flutter_core.dart';
import '../../core/governance/governance_provider.dart';
import '../models/governance_report.dart';
import '../services/production_readiness_service.dart';
import '../services/screen_governance_reporter.dart';

/// A read-only registry analysis, never a production verification receipt.
class PlatformReadinessSnapshot {
  static const source = 'registry metadata analysis; not production verification';
  final Map<String, ScreenMetadata> screens;
  final Map<String, List<String>> pendingEvidence;
  final GovernanceReport report;

  PlatformReadinessSnapshot._(this.screens, this.pendingEvidence, this.report);

  factory PlatformReadinessSnapshot.fromScreens(Map<String, ScreenMetadata> source) {
    final screens = Map<String, ScreenMetadata>.unmodifiable(source);
    final blockers = Map<String, List<String>>.unmodifiable({
      for (final screen in screens.values)
        screen.id: List<String>.unmodifiable(
          ProductionReadinessService.readinessBlockers(screen)),
    });
    return PlatformReadinessSnapshot._(
      screens, blockers, ScreenGovernanceReporter.scan(screens));
  }
}

final platformReadinessViewerControllerProvider = Provider<PlatformReadinessSnapshot>(
  (ref) => PlatformReadinessSnapshot.fromScreens(
    ref.watch(governanceProvider).allScreens),
);
