import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientCarePlanScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  PatientCarePlanScreenState({required this.isLoading, this.error, required this.data});

  PatientCarePlanScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return PatientCarePlanScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class PatientCarePlanScreenController extends StateNotifier<PatientCarePlanScreenState> {
  final Ref ref;
  PatientCarePlanScreenController(this.ref) : super(PatientCarePlanScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/common/patient-care-plan');
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

final patient_care_planControllerProvider = StateNotifierProvider<PatientCarePlanScreenController, PatientCarePlanScreenState>((ref) {
  return PatientCarePlanScreenController(ref);
});
