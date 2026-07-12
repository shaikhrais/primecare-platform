import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/supply_chain_cost_analyzer_model.dart';

class SupplyChainCostAnalyzerNotifier extends StateNotifier<SupplyChainCostAnalyzerModel> {
  SupplyChainCostAnalyzerNotifier() : super(const SupplyChainCostAnalyzerModel(isLoading: true));

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

final supply_chain_cost_analyzerProvider = StateNotifierProvider<SupplyChainCostAnalyzerNotifier, SupplyChainCostAnalyzerModel>((ref) {
  return SupplyChainCostAnalyzerNotifier()..loadData();
});
