// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final systemVerificationAdapterProvider =
    FutureProvider<Result<SystemVerificationViewModel>>((ref) async {
  final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);
  const cacheKey = 'system_verification_metrics';

  // Watch the hardened infrastructure provider
  final result = await ref.watch(databaseReportProvider.future);

  return result.fold(
    (data) {
      final viewModel = SystemVerificationViewModel.fromJson(data);
      // Persist LKG for offline survival
      unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

      telemetry.passGate(
        ExecutionGateCategory.resilience,
        'Dashboard route hydrated',
      );
      return Success(viewModel);
    },
    (error) {
      telemetry.passGate(
        ExecutionGateCategory.resilience,
        'SystemVerification Metrics Logistics Fallback Triggered',
      );
      // Automatic Resilience: Revert to LKG if infrastructure is unreachable
      final snapshot = resilience.getSnapshot(cacheKey);
      if (snapshot != null) {
        final vm = SystemVerificationViewModel.fromJson(snapshot as Map<String, dynamic>);
        return Success(SystemVerificationViewModel(
          metrics: vm.metrics,
          insights: vm.insights,
          blueprints: vm.blueprints,
          isOfflineFallback: true,
        ));
      }
      return Success(SystemVerificationViewModel.empty(isOfflineFallback: true));
    },
  );
});

