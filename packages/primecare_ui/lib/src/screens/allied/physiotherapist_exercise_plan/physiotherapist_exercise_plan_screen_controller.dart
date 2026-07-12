import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhysiotherapistExercisePlanScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  PhysiotherapistExercisePlanScreenState({required this.isLoading, this.error, required this.data});

  PhysiotherapistExercisePlanScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return PhysiotherapistExercisePlanScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class PhysiotherapistExercisePlanScreenController extends StateNotifier<PhysiotherapistExercisePlanScreenState> {
  final Ref ref;
  PhysiotherapistExercisePlanScreenController(this.ref) : super(PhysiotherapistExercisePlanScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/physiotherapist/exercise-plan');
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

final physiotherapist_exercise_planControllerProvider = StateNotifierProvider<PhysiotherapistExercisePlanScreenController, PhysiotherapistExercisePlanScreenState>((ref) {
  return PhysiotherapistExercisePlanScreenController(ref);
});
