import 'package:flutter_riverpod/legacy.dart';
import '../models/franchise_sales_manager_proposals_model.dart';

class FranchiseSalesManagerProposalsNotifier extends StateNotifier<FranchiseSalesManagerProposalsModel> {
  FranchiseSalesManagerProposalsNotifier() : super(const FranchiseSalesManagerProposalsModel(isLoading: true));

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

final franchise_sales_manager_proposalsProvider = StateNotifierProvider<FranchiseSalesManagerProposalsNotifier, FranchiseSalesManagerProposalsModel>((ref) {
  return FranchiseSalesManagerProposalsNotifier()..loadData();
});
