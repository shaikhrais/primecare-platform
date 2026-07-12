import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrDirectorHiringPipelineScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  HrDirectorHiringPipelineScreenState({required this.isLoading, this.error, required this.data});

  HrDirectorHiringPipelineScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return HrDirectorHiringPipelineScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class HrDirectorHiringPipelineScreenController extends StateNotifier<HrDirectorHiringPipelineScreenState> {
  final Ref ref;
  HrDirectorHiringPipelineScreenController(this.ref) : super(HrDirectorHiringPipelineScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/executive/hr-director-hiring-pipeline');
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

final hr_director_hiring_pipelineControllerProvider = StateNotifierProvider<HrDirectorHiringPipelineScreenController, HrDirectorHiringPipelineScreenState>((ref) {
  return HrDirectorHiringPipelineScreenController(ref);
});
