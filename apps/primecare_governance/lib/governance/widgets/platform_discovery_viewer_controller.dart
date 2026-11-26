import 'package:flutter_core/flutter_core.dart';
import '../../core/governance/governance_provider.dart';

class PlatformDiscoverySnapshot {
  final bool available;
  final Map<String, String> services;
  PlatformDiscoverySnapshot._(this.available, this.services);

  factory PlatformDiscoverySnapshot.fromObservation({
    required bool available, required Map<String, dynamic> services,
  }) {
    if (!available || services.entries.any((entry) =>
        entry.key.isEmpty || entry.value is! String || (entry.value as String).isEmpty)) {
      return PlatformDiscoverySnapshot._(false, const {});
    }
    return PlatformDiscoverySnapshot._(true, Map<String, String>.unmodifiable(
      services.map((key, value) => MapEntry(key, value as String))));
  }
}

final platformDiscoveryViewerControllerProvider = Provider<PlatformDiscoverySnapshot>((ref) {
  final state = ref.watch(governanceProvider);
  return PlatformDiscoverySnapshot.fromObservation(
    available: state.telemetryAvailable, services: state.liveServiceHealth);
});
