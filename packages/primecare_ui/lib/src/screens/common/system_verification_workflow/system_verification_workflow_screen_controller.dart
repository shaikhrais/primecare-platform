import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SystemVerificationWorkflowScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  SystemVerificationWorkflowScreenState({required this.isLoading, this.error, required this.data});

  SystemVerificationWorkflowScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return SystemVerificationWorkflowScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class SystemVerificationWorkflowScreenController extends StateNotifier<SystemVerificationWorkflowScreenState> {
  final Ref ref;
  SystemVerificationWorkflowScreenController(this.ref) : super(SystemVerificationWorkflowScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/common/system-verification-workflow');
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

final system_verification_workflowControllerProvider = StateNotifierProvider<SystemVerificationWorkflowScreenController, SystemVerificationWorkflowScreenState>((ref) {
  return SystemVerificationWorkflowScreenController(ref);
});
