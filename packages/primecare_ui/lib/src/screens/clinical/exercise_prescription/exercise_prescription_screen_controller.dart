import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExercisePrescriptionScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  ExercisePrescriptionScreenState({required this.isLoading, this.error, required this.data});

  ExercisePrescriptionScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return ExercisePrescriptionScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class ExercisePrescriptionScreenController extends StateNotifier<ExercisePrescriptionScreenState> {
  final Ref ref;
  ExercisePrescriptionScreenController(this.ref) : super(ExercisePrescriptionScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/physiotherapist/exercise-prescription');
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

final exercise_prescriptionControllerProvider = StateNotifierProvider<ExercisePrescriptionScreenController, ExercisePrescriptionScreenState>((ref) {
  return ExercisePrescriptionScreenController(ref);
});
