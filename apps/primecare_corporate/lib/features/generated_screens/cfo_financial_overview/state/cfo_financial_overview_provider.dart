import 'package:flutter_riverpod/legacy.dart';
import '../models/cfo_financial_overview_model.dart';

class CfoFinancialOverviewNotifier extends StateNotifier<CfoFinancialOverviewModel> {
  CfoFinancialOverviewNotifier() : super(const CfoFinancialOverviewModel(isLoading: true));

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

final cfo_financial_overviewProvider = StateNotifierProvider<CfoFinancialOverviewNotifier, CfoFinancialOverviewModel>((ref) {
  return CfoFinancialOverviewNotifier()..loadData();
});
