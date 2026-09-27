import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicWorkflowScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  ClinicWorkflowScreenState({required this.isLoading, this.error, required this.data});

  ClinicWorkflowScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return ClinicWorkflowScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class ClinicWorkflowScreenController extends StateNotifier<ClinicWorkflowScreenState> {
  final Ref ref;
  ClinicWorkflowScreenController(this.ref) : super(ClinicWorkflowScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/clinical_director/clinic-workflow');
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

final clinic_workflowControllerProvider = StateNotifierProvider<ClinicWorkflowScreenController, ClinicWorkflowScreenState>((ref) {
  return ClinicWorkflowScreenController(ref);
});
