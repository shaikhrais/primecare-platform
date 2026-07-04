import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/coo_branch_comparison_model.dart';

class CooBranchComparisonNotifier extends StateNotifier<CooBranchComparisonModel> {
  CooBranchComparisonNotifier() : super(const CooBranchComparisonModel(isLoading: true));

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

final coo_branch_comparisonProvider = StateNotifierProvider<CooBranchComparisonNotifier, CooBranchComparisonModel>((ref) {
  return CooBranchComparisonNotifier()..loadData();
});
