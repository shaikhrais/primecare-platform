import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/regional_bdm_territory_growth_model.dart';

class RegionalBdmTerritoryGrowthNotifier extends StateNotifier<RegionalBdmTerritoryGrowthModel> {
  RegionalBdmTerritoryGrowthNotifier() : super(const RegionalBdmTerritoryGrowthModel(isLoading: true));

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

final regional_bdm_territory_growthProvider = StateNotifierProvider<RegionalBdmTerritoryGrowthNotifier, RegionalBdmTerritoryGrowthModel>((ref) {
  return RegionalBdmTerritoryGrowthNotifier()..loadData();
});
