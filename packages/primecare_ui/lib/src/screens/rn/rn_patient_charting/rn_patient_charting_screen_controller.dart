import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnPatientChartingScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  RnPatientChartingScreenState({required this.isLoading, this.error, required this.data});

  RnPatientChartingScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return RnPatientChartingScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class RnPatientChartingScreenController extends StateNotifier<RnPatientChartingScreenState> {
  final Ref ref;
  RnPatientChartingScreenController(this.ref) : super(RnPatientChartingScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/rn/patient-charting');
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

final rn_patient_chartingControllerProvider = StateNotifierProvider<RnPatientChartingScreenController, RnPatientChartingScreenState>((ref) {
  return RnPatientChartingScreenController(ref);
});
