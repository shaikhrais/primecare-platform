import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final auraPulseServiceProvider = Provider<AuraPulseService>((ref) {
  final service = AuraPulseService(ref);
  service.start();
  ref.onDispose(() => service.stop());
  return service;
});

final auraPulseProvider = StreamProvider<AuraEvent>((ref) {
  return ref.watch(auraPulseServiceProvider).pulse;
});

final auraActiveAnomalyProvider = Provider<AuraEvent?>((ref) {
  final pulse = ref.watch(auraPulseProvider).value;
  if (pulse != null &&
      (pulse.impact == InsightImpact.caution ||
          pulse.impact == InsightImpact.alert)) {
    return pulse;
  }
  return null;
});

/// Global toggle state to engage Aura predictive visualizations deeply within charts/dashboards.
class AuraActiveVisualizationNotifier extends Notifier<bool> {
  @override
  bool build() => false;
  void update(bool value) => state = value;
}

final auraActiveVisualizationProvider =
    NotifierProvider<AuraActiveVisualizationNotifier, bool>(() {
      return AuraActiveVisualizationNotifier();
    });

/// Global toggle state to snooze Aura HUD alerts.
class AuraSnoozeNotifier extends Notifier<bool> {
  @override
  bool build() => false;
  void update(bool value) => state = value;
}

final auraSnoozeProvider = NotifierProvider<AuraSnoozeNotifier, bool>(() {
  return AuraSnoozeNotifier();
});

/// Provider for the AuraCommandService instance.
final auraCommandServiceProvider = Provider<AuraCommandService>((ref) {
  return AuraCommandService();
});

/// State notifier for the current Aura query session.
class AuraQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void update(String query) => state = query;
}

/// Provider for the Aura query string.
final auraQueryProvider = NotifierProvider<AuraQueryNotifier, String>(() {
  return AuraQueryNotifier();
});

/// Computed provider that transforms the current query into an intent.
final auraIntentProvider = Provider.autoDispose((ref) {
  final service = ref.watch(auraCommandServiceProvider);
  final query = ref.watch(auraQueryProvider);

  if (query.isEmpty) return null;
  final intent = service.processQuery(query);
  if (intent.title == 'Query Interrupted') {
    ref
        .read(executionGateProvider)
        .failGate(
          ExecutionGateCategory.auraEngine,
          'Aura encountered a dynamic boundary issue',
          error: 'Parsing Exception',
          stackTrace: StackTrace.current,
        );
  } else {
    ref
        .read(executionGateProvider)
        .passGate(
          ExecutionGateCategory.auraEngine,
          'Processed NLP Intent: ${intent.title}',
        );
  }
  return intent;
});
