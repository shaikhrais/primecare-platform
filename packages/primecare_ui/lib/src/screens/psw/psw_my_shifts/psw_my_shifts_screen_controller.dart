import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswMyShiftsScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  PswMyShiftsScreenState({required this.isLoading, this.error, required this.data});

  PswMyShiftsScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return PswMyShiftsScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class PswMyShiftsScreenController extends StateNotifier<PswMyShiftsScreenState> {
  final Ref ref;
  PswMyShiftsScreenController(this.ref) : super(PswMyShiftsScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/psw/psw-my-shifts');
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

final psw_my_shiftsControllerProvider = StateNotifierProvider<PswMyShiftsScreenController, PswMyShiftsScreenState>((ref) {
  return PswMyShiftsScreenController(ref);
});
