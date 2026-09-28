import 'package:flutter_riverpod/legacy.dart';
import '../models/franchise_sales_manager_leads_model.dart';

class FranchiseSalesManagerLeadsNotifier extends StateNotifier<FranchiseSalesManagerLeadsModel> {
  FranchiseSalesManagerLeadsNotifier() : super(const FranchiseSalesManagerLeadsModel(isLoading: true));

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

final franchise_sales_manager_leadsProvider = StateNotifierProvider<FranchiseSalesManagerLeadsNotifier, FranchiseSalesManagerLeadsModel>((ref) {
  return FranchiseSalesManagerLeadsNotifier()..loadData();
});
