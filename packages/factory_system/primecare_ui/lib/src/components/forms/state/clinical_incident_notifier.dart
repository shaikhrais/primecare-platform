import 'package:primecare_core/flutter_core.dart';
import 'dart:async';


class ClinicalIncidentPayload {
  final Map<String, dynamic> data;

  const ClinicalIncidentPayload({required this.data});
}

class ClinicalIncidentNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // Initial state setup if loading from draft/api
    return null;
  }

  Future<void> submit(ClinicalIncidentPayload payload) async {
    // 1. Guard the future for global loading state
    state = const AsyncValue.loading();

    // 2. Perform the async operation globally via architecture pattern
    state = await AsyncValue.guard(() async {
      final result = await Result.guardFuture(() async {
        final client = ref.read(apiClientProvider);
        await client.post('/api/v1/orchestration/actions', body: payload.data);
      });
      if (result.isFailure) {
        throw Exception(result.errorOrNull.toString());
      }
    });

    // 3. Telemetry tracking
    if (!state.hasError) {
      ref
          .read(executionGateProvider)
          .passGate(
            ExecutionGateCategory.ui,
            'ClinicalIncidentForm submitted successfully',
          );
    }
  }
}

final clinicalIncidentProvider =
    AsyncNotifierProvider<ClinicalIncidentNotifier, void>(
      () => ClinicalIncidentNotifier(),
    );
