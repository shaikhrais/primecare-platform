import 'package:flutter_riverpod/legacy.dart';
import '../models/territory_expansion_manager_open_territories_model.dart';

class TerritoryExpansionManagerOpenTerritoriesNotifier extends StateNotifier<TerritoryExpansionManagerOpenTerritoriesModel> {
  TerritoryExpansionManagerOpenTerritoriesNotifier() : super(const TerritoryExpansionManagerOpenTerritoriesModel(isLoading: true));

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

final territory_expansion_manager_open_territoriesProvider = StateNotifierProvider<TerritoryExpansionManagerOpenTerritoriesNotifier, TerritoryExpansionManagerOpenTerritoriesModel>((ref) {
  return TerritoryExpansionManagerOpenTerritoriesNotifier()..loadData();
});
