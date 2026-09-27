import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/franchise_sales_manager_sales_pipeline_model.dart';

class FranchiseSalesManagerSalesPipelineNotifier extends StateNotifier<FranchiseSalesManagerSalesPipelineModel> {
  FranchiseSalesManagerSalesPipelineNotifier() : super(const FranchiseSalesManagerSalesPipelineModel(isLoading: true));

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

final franchise_sales_manager_sales_pipelineProvider = StateNotifierProvider<FranchiseSalesManagerSalesPipelineNotifier, FranchiseSalesManagerSalesPipelineModel>((ref) {
  return FranchiseSalesManagerSalesPipelineNotifier()..loadData();
});
