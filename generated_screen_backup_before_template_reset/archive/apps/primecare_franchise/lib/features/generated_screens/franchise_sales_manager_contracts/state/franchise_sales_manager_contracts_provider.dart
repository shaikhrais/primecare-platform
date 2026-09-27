import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/franchise_sales_manager_contracts_model.dart';

class FranchiseSalesManagerContractsNotifier extends StateNotifier<FranchiseSalesManagerContractsModel> {
  FranchiseSalesManagerContractsNotifier() : super(const FranchiseSalesManagerContractsModel(isLoading: true));

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

final franchise_sales_manager_contractsProvider = StateNotifierProvider<FranchiseSalesManagerContractsNotifier, FranchiseSalesManagerContractsModel>((ref) {
  return FranchiseSalesManagerContractsNotifier()..loadData();
});
