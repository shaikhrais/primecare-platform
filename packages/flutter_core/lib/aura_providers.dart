import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final auraPulseServiceProvider = Provider<AuraPulseService>((ref) {
  final service = AuraPulseService();
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
  return service.processQuery(query);
});
