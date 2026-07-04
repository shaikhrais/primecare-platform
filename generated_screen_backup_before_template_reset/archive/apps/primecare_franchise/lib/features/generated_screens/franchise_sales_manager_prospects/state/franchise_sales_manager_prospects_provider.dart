import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/franchise_sales_manager_prospects_model.dart';

class FranchiseSalesManagerProspectsNotifier extends StateNotifier<FranchiseSalesManagerProspectsModel> {
  FranchiseSalesManagerProspectsNotifier() : super(const FranchiseSalesManagerProspectsModel(isLoading: true));

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

final franchise_sales_manager_prospectsProvider = StateNotifierProvider<FranchiseSalesManagerProspectsNotifier, FranchiseSalesManagerProspectsModel>((ref) {
  return FranchiseSalesManagerProspectsNotifier()..loadData();
});
