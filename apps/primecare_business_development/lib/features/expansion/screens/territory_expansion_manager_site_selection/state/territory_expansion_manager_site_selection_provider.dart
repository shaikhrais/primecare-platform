import 'package:flutter_riverpod/legacy.dart';
import '../models/territory_expansion_manager_site_selection_model.dart';

class TerritoryExpansionManagerSiteSelectionNotifier extends StateNotifier<TerritoryExpansionManagerSiteSelectionModel> {
  TerritoryExpansionManagerSiteSelectionNotifier() : super(const TerritoryExpansionManagerSiteSelectionModel(isLoading: true));

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

final territory_expansion_manager_site_selectionProvider = StateNotifierProvider<TerritoryExpansionManagerSiteSelectionNotifier, TerritoryExpansionManagerSiteSelectionModel>((ref) {
  return TerritoryExpansionManagerSiteSelectionNotifier()..loadData();
});
