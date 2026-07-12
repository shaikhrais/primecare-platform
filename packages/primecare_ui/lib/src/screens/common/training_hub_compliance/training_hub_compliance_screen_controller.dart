import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingHubComplianceScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  TrainingHubComplianceScreenState({required this.isLoading, this.error, required this.data});

  TrainingHubComplianceScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return TrainingHubComplianceScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class TrainingHubComplianceScreenController extends StateNotifier<TrainingHubComplianceScreenState> {
  final Ref ref;
  TrainingHubComplianceScreenController(this.ref) : super(TrainingHubComplianceScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/common/training-hub-compliance');
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          data: response.data is Map ? Map<String, dynamic>.from(response.data) : {},
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response.error ?? 'Failed to load live data',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> syncData() async {
    await loadDashboardData();
  }
}

final training_hub_complianceControllerProvider = StateNotifierProvider<TrainingHubComplianceScreenController, TrainingHubComplianceScreenState>((ref) {
  return TrainingHubComplianceScreenController(ref);
});
