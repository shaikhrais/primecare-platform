import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseOwnerBranchOverviewScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  FranchiseOwnerBranchOverviewScreenState({required this.isLoading, this.error, required this.data});

  FranchiseOwnerBranchOverviewScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return FranchiseOwnerBranchOverviewScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class FranchiseOwnerBranchOverviewScreenController extends StateNotifier<FranchiseOwnerBranchOverviewScreenState> {
  final Ref ref;
  FranchiseOwnerBranchOverviewScreenController(this.ref) : super(FranchiseOwnerBranchOverviewScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/franchise/roles/franchise_owner/branch-overview');
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

final franchise_owner_branch_overviewControllerProvider = StateNotifierProvider<FranchiseOwnerBranchOverviewScreenController, FranchiseOwnerBranchOverviewScreenState>((ref) {
  return FranchiseOwnerBranchOverviewScreenController(ref);
});
