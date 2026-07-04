import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/franchise_overview_model.dart';

class FranchiseOverviewNotifier extends StateNotifier<FranchiseOverviewModel> {
  FranchiseOverviewNotifier() : super(const FranchiseOverviewModel(isLoading: true));

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

final franchise_overviewProvider = StateNotifierProvider<FranchiseOverviewNotifier, FranchiseOverviewModel>((ref) {
  return FranchiseOverviewNotifier()..loadData();
});
