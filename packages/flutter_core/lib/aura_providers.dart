// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/primecare_ui.dart';

/// Track the current institutional context (e.g., active office or feature).
/// This allows Aura to surface screen-specific insights and commands.
class AuraContextNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void update(String? context) => state = context;
}

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
    ref.read(auraPulseEventProvider.notifier).state = event;
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

/// Surfaces contextual suggestions based on the active platform context.
final auraContextualSuggestionsProvider = Provider<List<String>>((ref) {
  final context = ref.watch(auraContextProvider);
  final service = ref.watch(auraCommandServiceProvider);
  return service.getSuggestions(context: context);
});
