// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/flutter_core.dart';
import 'dart:async';

class MedicationAdministrationPayload {
  final Map<String, dynamic> data;

  const MedicationAdministrationPayload({required this.data});
}

class MedicationAdministrationNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // Initial state setup if loading from draft/api
    return null;
  }

  Future<void> submit(MedicationAdministrationPayload payload) async {
    // 1. Guard the future for global loading state
    state = const AsyncValue.loading();

    // 2. Perform the async operation globally via architecture pattern
    state = await AsyncValue.guard(() async {
      final result = await Result.guardFuture(() async {
        final client = ref.read(apiClientProvider);
        await client.post('/api/v1/orchestration/actions', body: payload.data);
      });
      result.fold((_) => null, (error) => throw Exception(error.toString()));
    });

    // 3. Telemetry tracking
    if (!state.hasError) {
      ref
          .read(executionGateProvider)
          .passGate(
            ExecutionGateCategory.ui,
            'MedicationAdministrationForm submitted successfully',
          );
    }
  }
}

final medicationAdministrationProvider =
    AsyncNotifierProvider<MedicationAdministrationNotifier, void>(
      () => MedicationAdministrationNotifier(),
    );
