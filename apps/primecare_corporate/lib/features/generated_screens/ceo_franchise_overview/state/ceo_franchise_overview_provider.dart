import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ceo_franchise_overview_model.dart';

class CeoFranchiseOverviewNotifier extends StateNotifier<CeoFranchiseOverviewModel> {
  CeoFranchiseOverviewNotifier() : super(const CeoFranchiseOverviewModel(isLoading: true));

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

final ceo_franchise_overviewProvider = StateNotifierProvider<CeoFranchiseOverviewNotifier, CeoFranchiseOverviewModel>((ref) {
  return CeoFranchiseOverviewNotifier()..loadData();
});
