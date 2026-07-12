import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicalWorkflowScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  ClinicalWorkflowScreenState({required this.isLoading, this.error, required this.data});

  ClinicalWorkflowScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return ClinicalWorkflowScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class ClinicalWorkflowScreenController extends StateNotifier<ClinicalWorkflowScreenState> {
  final Ref ref;
  ClinicalWorkflowScreenController(this.ref) : super(ClinicalWorkflowScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/clinical_director/workflow');
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

final clinical_workflowControllerProvider = StateNotifierProvider<ClinicalWorkflowScreenController, ClinicalWorkflowScreenState>((ref) {
  return ClinicalWorkflowScreenController(ref);
});
