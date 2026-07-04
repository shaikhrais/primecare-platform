import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/branch_performance_model.dart';

class BranchPerformanceNotifier extends StateNotifier<BranchPerformanceModel> {
  BranchPerformanceNotifier() : super(const BranchPerformanceModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const {});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final branch_performanceProvider = StateNotifierProvider<BranchPerformanceNotifier, BranchPerformanceModel>((ref) {
  return BranchPerformanceNotifier()..loadData();
});
