// Governance - Category: controller | Purpose: Layer: 01_INFRASTRUCTURE Track the current institutional context (e.g., active office or feature). This allows Aura t...
// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/flutter_core.dart';
import 'src/controllers/base_value_notifier.dart';

part 'src/controllers/aura_context_notifier.dart';
part 'src/controllers/aura_active_visualization_notifier.dart';
part 'src/controllers/aura_snooze_notifier.dart';
part 'src/controllers/aura_query_notifier.dart';
part 'src/controllers/aura_pulse_event_notifier.dart';



final auraContextProvider = NotifierProvider<AuraContextNotifier, String?>(() {
  return AuraContextNotifier();
});

final auraPulseServiceProvider = Provider<AuraPulseService>((ref) {
  final service = AuraPulseService(ref);
  service.start();
  ref.onDispose(() => service.stop());
  return service;
});

final auraPulseProvider = StreamProvider<AuraEvent>((ref) {
  final pulseStream = ref.watch(auraPulseServiceProvider).pulse;

  // Bridge the pulse to the UI-layer provider in primecare_ui
  final subscription = pulseStream.listen((event) {
    ref.read(auraPulseEventProvider.notifier).update(event);
  });

  ref.onDispose(() => subscription.cancel());

  return pulseStream;
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



final auraActiveVisualizationProvider =
    NotifierProvider<AuraActiveVisualizationNotifier, bool>(() {
      return AuraActiveVisualizationNotifier();
    });



final auraSnoozeProvider = NotifierProvider<AuraSnoozeNotifier, bool>(() {
  return AuraSnoozeNotifier();
});

/// Provider for the AuraCommandService instance.
final auraCommandServiceProvider = Provider<AuraCommandService>((ref) {
  return AuraCommandService();
});



/// Provider for the Aura query string.
final auraQueryProvider = NotifierProvider<AuraQueryNotifier, String>(() {
  return AuraQueryNotifier();
});

/// Computed provider that transforms the current query into an intent.
final auraIntentProvider = Provider.autoDispose((ref) {
  final service = ref.watch(auraCommandServiceProvider);
  final query = ref.watch(auraQueryProvider);

  if (query.isEmpty) return null;

  final result = service.processQuery(query);

  return result.fold(
    (intent) {
      if (intent.title == 'Query Interrupted') {
        ref
            .read<ExecutionGateService>(executionGateProvider)
            .failGate(
              ExecutionGateCategory.auraEngine,
              'Aura encountered a dynamic boundary issue',
              error: 'Parsing Exception',
              stackTrace: StackTrace.current,
            );
      } else {
        ref
            .read<ExecutionGateService>(executionGateProvider)
            .passGate(
              ExecutionGateCategory.auraEngine,
              'Processed NLP Intent: ${intent.title}',
            );
      }
      return intent;
    },
    (error) {
      // This case should be rare as processQuery has its own guard,
      // but we handle it for absolute safety.
      ref
          .read<ExecutionGateService>(executionGateProvider)
          .failGate(
            ExecutionGateCategory.auraEngine,
            'Aura critical failure',
            error: error.runtimeType,
          );
      return null;
    },
  );
});

/// surfaces contextual suggestions based on the active platform context.
final auraContextualSuggestionsProvider = Provider<List<String>>((ref) {
  final context = ref.watch(auraContextProvider);
  final service = ref.watch(auraCommandServiceProvider);
  return service.getSuggestions(context: context);
});



final auraPulseEventProvider =
    NotifierProvider<AuraPulseEventNotifier, AuraEvent?>(() {
      return AuraPulseEventNotifier();
    });
