import 'package:flutter_riverpod/legacy.dart';
import '../models/regional_manager_branch_comparison_model.dart';

class RegionalManagerBranchComparisonNotifier extends StateNotifier<RegionalManagerBranchComparisonModel> {
  RegionalManagerBranchComparisonNotifier() : super(const RegionalManagerBranchComparisonModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const <String, dynamic>{});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final regional_manager_branch_comparisonProvider = StateNotifierProvider<RegionalManagerBranchComparisonNotifier, RegionalManagerBranchComparisonModel>((ref) {
  return RegionalManagerBranchComparisonNotifier()..loadData();
});
