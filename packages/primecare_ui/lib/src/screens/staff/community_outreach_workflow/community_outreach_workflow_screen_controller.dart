import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunityOutreachWorkflowScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  CommunityOutreachWorkflowScreenState({required this.isLoading, this.error, required this.data});

  CommunityOutreachWorkflowScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return CommunityOutreachWorkflowScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class CommunityOutreachWorkflowScreenController extends StateNotifier<CommunityOutreachWorkflowScreenState> {
  final Ref ref;
  CommunityOutreachWorkflowScreenController(this.ref) : super(CommunityOutreachWorkflowScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/management/community-outreach-workflow');
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

final community_outreach_workflowControllerProvider = StateNotifierProvider<CommunityOutreachWorkflowScreenController, CommunityOutreachWorkflowScreenState>((ref) {
  return CommunityOutreachWorkflowScreenController(ref);
});
