import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OfficeWorkflowScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  OfficeWorkflowScreenState({required this.isLoading, this.error, required this.data});

  OfficeWorkflowScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return OfficeWorkflowScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class OfficeWorkflowScreenController extends StateNotifier<OfficeWorkflowScreenState> {
  final Ref ref;
  OfficeWorkflowScreenController(this.ref) : super(OfficeWorkflowScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/common/office-workflow');
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

final office_workflowControllerProvider = StateNotifierProvider<OfficeWorkflowScreenController, OfficeWorkflowScreenState>((ref) {
  return OfficeWorkflowScreenController(ref);
});
