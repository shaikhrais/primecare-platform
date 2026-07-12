import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShareholderWorkflowScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  ShareholderWorkflowScreenState({required this.isLoading, this.error, required this.data});

  ShareholderWorkflowScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return ShareholderWorkflowScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class ShareholderWorkflowScreenController extends StateNotifier<ShareholderWorkflowScreenState> {
  final Ref ref;
  ShareholderWorkflowScreenController(this.ref) : super(ShareholderWorkflowScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/executive/shareholder-workflow');
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

final shareholder_workflowControllerProvider = StateNotifierProvider<ShareholderWorkflowScreenController, ShareholderWorkflowScreenState>((ref) {
  return ShareholderWorkflowScreenController(ref);
});
