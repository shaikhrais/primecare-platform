import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingCoordinatorComplianceScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  TrainingCoordinatorComplianceScreenState({required this.isLoading, this.error, required this.data});

  TrainingCoordinatorComplianceScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return TrainingCoordinatorComplianceScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class TrainingCoordinatorComplianceScreenController extends StateNotifier<TrainingCoordinatorComplianceScreenState> {
  final Ref ref;
  TrainingCoordinatorComplianceScreenController(this.ref) : super(TrainingCoordinatorComplianceScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/staff/training-coordinator-compliance');
      if (response.isSuccess) {
        final responseData = response.data;
        state = state.copyWith(
          isLoading: false,
          data: responseData is Map ? Map<String, dynamic>.from(responseData) : {},
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

final training_coordinator_complianceControllerProvider = StateNotifierProvider<TrainingCoordinatorComplianceScreenController, TrainingCoordinatorComplianceScreenState>((ref) {
  return TrainingCoordinatorComplianceScreenController(ref);
});
