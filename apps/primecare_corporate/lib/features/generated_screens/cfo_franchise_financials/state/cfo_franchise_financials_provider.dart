import 'package:flutter_riverpod/legacy.dart';
import '../models/cfo_franchise_financials_model.dart';

class CfoFranchiseFinancialsNotifier extends StateNotifier<CfoFranchiseFinancialsModel> {
  CfoFranchiseFinancialsNotifier() : super(const CfoFranchiseFinancialsModel(isLoading: true));

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

final cfo_franchise_financialsProvider = StateNotifierProvider<CfoFranchiseFinancialsNotifier, CfoFranchiseFinancialsModel>((ref) {
  return CfoFranchiseFinancialsNotifier()..loadData();
});
