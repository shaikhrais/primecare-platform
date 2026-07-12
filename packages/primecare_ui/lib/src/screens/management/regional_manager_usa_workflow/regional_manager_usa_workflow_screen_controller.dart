import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegionalManagerUsaWorkflowScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  RegionalManagerUsaWorkflowScreenState({required this.isLoading, this.error, required this.data});

  RegionalManagerUsaWorkflowScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return RegionalManagerUsaWorkflowScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class RegionalManagerUsaWorkflowScreenController extends StateNotifier<RegionalManagerUsaWorkflowScreenState> {
  final Ref ref;
  RegionalManagerUsaWorkflowScreenController(this.ref) : super(RegionalManagerUsaWorkflowScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/management/regional-manager-usa-workflow');
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

final regional_manager_usa_workflowControllerProvider = StateNotifierProvider<RegionalManagerUsaWorkflowScreenController, RegionalManagerUsaWorkflowScreenState>((ref) {
  return RegionalManagerUsaWorkflowScreenController(ref);
});
