import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RpnPatientChartingScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  RpnPatientChartingScreenState({required this.isLoading, this.error, required this.data});

  RpnPatientChartingScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return RpnPatientChartingScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class RpnPatientChartingScreenController extends StateNotifier<RpnPatientChartingScreenState> {
  final Ref ref;
  RpnPatientChartingScreenController(this.ref) : super(RpnPatientChartingScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/rpn/patient-charting');
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

final rpn_patient_chartingControllerProvider = StateNotifierProvider<RpnPatientChartingScreenController, RpnPatientChartingScreenState>((ref) {
  return RpnPatientChartingScreenController(ref);
});
