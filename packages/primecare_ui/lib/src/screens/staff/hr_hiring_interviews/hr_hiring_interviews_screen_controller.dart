import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrHiringInterviewsScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  HrHiringInterviewsScreenState({required this.isLoading, this.error, required this.data});

  HrHiringInterviewsScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return HrHiringInterviewsScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class HrHiringInterviewsScreenController extends StateNotifier<HrHiringInterviewsScreenState> {
  final Ref ref;
  HrHiringInterviewsScreenController(this.ref) : super(HrHiringInterviewsScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/franchise/roles/hr_hiring/interviews');
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

final hr_hiring_interviewsControllerProvider = StateNotifierProvider<HrHiringInterviewsScreenController, HrHiringInterviewsScreenState>((ref) {
  return HrHiringInterviewsScreenController(ref);
});
