import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/franchise_owner_branch_overview_model.dart';

class FranchiseOwnerBranchOverviewNotifier extends StateNotifier<FranchiseOwnerBranchOverviewModel> {
  FranchiseOwnerBranchOverviewNotifier() : super(const FranchiseOwnerBranchOverviewModel(isLoading: true));

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

final franchise_owner_branch_overviewProvider = StateNotifierProvider<FranchiseOwnerBranchOverviewNotifier, FranchiseOwnerBranchOverviewModel>((ref) {
  return FranchiseOwnerBranchOverviewNotifier()..loadData();
});
