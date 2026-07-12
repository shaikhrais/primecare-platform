import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CooBranchComparisonScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  CooBranchComparisonScreenState({required this.isLoading, this.error, required this.data});

  CooBranchComparisonScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return CooBranchComparisonScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class CooBranchComparisonScreenController extends StateNotifier<CooBranchComparisonScreenState> {
  final Ref ref;
  CooBranchComparisonScreenController(this.ref) : super(CooBranchComparisonScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/corporate/roles/coo/branch-comparison');
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

final coo_branch_comparisonControllerProvider = StateNotifierProvider<CooBranchComparisonScreenController, CooBranchComparisonScreenState>((ref) {
  return CooBranchComparisonScreenController(ref);
});
