import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QualityAssuranceWorkflowScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  QualityAssuranceWorkflowScreenState({required this.isLoading, this.error, required this.data});

  QualityAssuranceWorkflowScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return QualityAssuranceWorkflowScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class QualityAssuranceWorkflowScreenController extends StateNotifier<QualityAssuranceWorkflowScreenState> {
  final Ref ref;
  QualityAssuranceWorkflowScreenController(this.ref) : super(QualityAssuranceWorkflowScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/staff/quality-assurance-workflow');
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

final quality_assurance_workflowControllerProvider = StateNotifierProvider<QualityAssuranceWorkflowScreenController, QualityAssuranceWorkflowScreenState>((ref) {
  return QualityAssuranceWorkflowScreenController(ref);
});
