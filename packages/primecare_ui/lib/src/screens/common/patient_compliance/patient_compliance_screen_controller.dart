import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientComplianceScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  PatientComplianceScreenState({required this.isLoading, this.error, required this.data});

  PatientComplianceScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return PatientComplianceScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class PatientComplianceScreenController extends StateNotifier<PatientComplianceScreenState> {
  final Ref ref;
  PatientComplianceScreenController(this.ref) : super(PatientComplianceScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/common/patient-compliance');
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

final patient_complianceControllerProvider = StateNotifierProvider<PatientComplianceScreenController, PatientComplianceScreenState>((ref) {
  return PatientComplianceScreenController(ref);
});
