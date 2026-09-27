import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingManagementScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  TrainingManagementScreenState({required this.isLoading, this.error, required this.data});

  TrainingManagementScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return TrainingManagementScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class TrainingManagementScreenController extends StateNotifier<TrainingManagementScreenState> {
  final Ref ref;
  TrainingManagementScreenController(this.ref) : super(TrainingManagementScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/management/training-management');
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

final training_managementControllerProvider = StateNotifierProvider<TrainingManagementScreenController, TrainingManagementScreenState>((ref) {
  return TrainingManagementScreenController(ref);
});
