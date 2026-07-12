import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarePlanScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  CarePlanScreenState({required this.isLoading, this.error, required this.data});

  CarePlanScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return CarePlanScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class CarePlanScreenController extends StateNotifier<CarePlanScreenState> {
  final Ref ref;
  CarePlanScreenController(this.ref) : super(CarePlanScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/clinic/care-plan');
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

final care_planControllerProvider = StateNotifierProvider<CarePlanScreenController, CarePlanScreenState>((ref) {
  return CarePlanScreenController(ref);
});
