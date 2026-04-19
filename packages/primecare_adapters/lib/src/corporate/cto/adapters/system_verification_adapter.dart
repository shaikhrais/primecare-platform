import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final systemVerificationAdapterProvider =
    FutureProvider<Result<SystemVerificationViewModel>>((ref) async {
  final resilience = ref.read(resilienceServiceProvider);
  const cacheKey = 'system_verification_metrics';

  // Watch the hardened infrastructure provider
  final result = await ref.watch(databaseReportProvider.future);

  return result.fold(
    (data) {
      final viewModel = SystemVerificationViewModel.fromJson(data);
      // Persist LKG for offline survival
      unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
      return Success(viewModel);
    },
    (error) {
      // Automatic Resilience: Revert to LKG if infrastructure is unreachable
      final snapshot = resilience.getSnapshot(cacheKey);
      if (snapshot != null) {
        return Success(SystemVerificationViewModel.fromJson(snapshot));
      }
      return Success(SystemVerificationViewModel.assemble(isOffline: true));
    },
  );
});
