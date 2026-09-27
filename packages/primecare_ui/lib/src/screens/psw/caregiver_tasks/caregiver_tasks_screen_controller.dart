import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CaregiverTasksScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  CaregiverTasksScreenState({required this.isLoading, this.error, required this.data});

  CaregiverTasksScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return CaregiverTasksScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class CaregiverTasksScreenController extends StateNotifier<CaregiverTasksScreenState> {
  final Ref ref;
  CaregiverTasksScreenController(this.ref) : super(CaregiverTasksScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/caregiver/tasks');
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

final caregiver_tasksControllerProvider = StateNotifierProvider<CaregiverTasksScreenController, CaregiverTasksScreenState>((ref) {
  return CaregiverTasksScreenController(ref);
});
