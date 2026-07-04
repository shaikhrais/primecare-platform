import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/territory_expansion_manager_market_research_model.dart';

class TerritoryExpansionManagerMarketResearchNotifier extends StateNotifier<TerritoryExpansionManagerMarketResearchModel> {
  TerritoryExpansionManagerMarketResearchNotifier() : super(const TerritoryExpansionManagerMarketResearchModel(isLoading: true));

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

final territory_expansion_manager_market_researchProvider = StateNotifierProvider<TerritoryExpansionManagerMarketResearchNotifier, TerritoryExpansionManagerMarketResearchModel>((ref) {
  return TerritoryExpansionManagerMarketResearchNotifier()..loadData();
});
