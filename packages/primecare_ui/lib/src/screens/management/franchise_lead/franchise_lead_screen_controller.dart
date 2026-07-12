import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseLeadScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  FranchiseLeadScreenState({required this.isLoading, this.error, required this.data});

  FranchiseLeadScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return FranchiseLeadScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class FranchiseLeadScreenController extends StateNotifier<FranchiseLeadScreenState> {
  final Ref ref;
  FranchiseLeadScreenController(this.ref) : super(FranchiseLeadScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/management/franchise-lead');
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

final franchise_leadControllerProvider = StateNotifierProvider<FranchiseLeadScreenController, FranchiseLeadScreenState>((ref) {
  return FranchiseLeadScreenController(ref);
});
