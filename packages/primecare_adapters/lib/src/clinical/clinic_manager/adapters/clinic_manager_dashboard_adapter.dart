import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final Provider<AsyncValue<Result<ClinicDashboardViewModel>>>
clinicManagerDashboardAdapterProvider =
    Provider<AsyncValue<Result<ClinicDashboardViewModel>>>((Ref ref) {
      final ClinicState state = ref.watch(clinicDashboardProvider);

      return state.when(
        initial: () {
          unawaited(
            Future<void>.microtask(() {
              ref.read(clinicDashboardProvider.notifier).loadData();
            }),
          );
          return const AsyncValue.loading();
        },
        loading: () => const AsyncValue.loading(),
        loaded: (ClinicData data) => AsyncValue.data(
          Success(ClinicDashboardViewModel.fromSaturatedData(data)),
        ),
        error: (String message) => AsyncValue.data(Failure(message)),
      );
    });
