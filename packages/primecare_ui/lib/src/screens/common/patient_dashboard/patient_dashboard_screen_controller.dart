import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientDashboardScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  PatientDashboardScreenState({required this.isLoading, this.error, required this.data});

  PatientDashboardScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return PatientDashboardScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class PatientDashboardScreenController extends StateNotifier<PatientDashboardScreenState> {
  final Ref ref;
  PatientDashboardScreenController(this.ref) : super(PatientDashboardScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/client/roles/client/dashboard');
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

final patient_dashboardControllerProvider = StateNotifierProvider<PatientDashboardScreenController, PatientDashboardScreenState>((ref) {
  return PatientDashboardScreenController(ref);
});
