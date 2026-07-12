import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HswCarePlansScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  HswCarePlansScreenState({required this.isLoading, this.error, required this.data});

  HswCarePlansScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return HswCarePlansScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class HswCarePlansScreenController extends StateNotifier<HswCarePlansScreenState> {
  final Ref ref;
  HswCarePlansScreenController(this.ref) : super(HswCarePlansScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/clinical/hsw-care-plans');
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

final hsw_care_plansControllerProvider = StateNotifierProvider<HswCarePlansScreenController, HswCarePlansScreenState>((ref) {
  return HswCarePlansScreenController(ref);
});
