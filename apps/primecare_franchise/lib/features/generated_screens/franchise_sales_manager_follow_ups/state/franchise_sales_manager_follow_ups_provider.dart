import 'package:flutter_riverpod/legacy.dart';
import '../models/franchise_sales_manager_follow_ups_model.dart';

class FranchiseSalesManagerFollowUpsNotifier extends StateNotifier<FranchiseSalesManagerFollowUpsModel> {
  FranchiseSalesManagerFollowUpsNotifier() : super(const FranchiseSalesManagerFollowUpsModel(isLoading: true));

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

final franchise_sales_manager_follow_upsProvider = StateNotifierProvider<FranchiseSalesManagerFollowUpsNotifier, FranchiseSalesManagerFollowUpsModel>((ref) {
  return FranchiseSalesManagerFollowUpsNotifier()..loadData();
});
