import 'package:flutter_riverpod/legacy.dart';
import '../models/franchise_sales_manager_reports_model.dart';

class FranchiseSalesManagerReportsNotifier extends StateNotifier<FranchiseSalesManagerReportsModel> {
  FranchiseSalesManagerReportsNotifier() : super(const FranchiseSalesManagerReportsModel(isLoading: true));

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

final franchise_sales_manager_reportsProvider = StateNotifierProvider<FranchiseSalesManagerReportsNotifier, FranchiseSalesManagerReportsModel>((ref) {
  return FranchiseSalesManagerReportsNotifier()..loadData();
});
