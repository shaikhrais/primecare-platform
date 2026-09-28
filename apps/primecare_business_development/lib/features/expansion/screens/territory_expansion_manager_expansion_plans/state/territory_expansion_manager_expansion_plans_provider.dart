import 'package:flutter_riverpod/legacy.dart';
import '../models/territory_expansion_manager_expansion_plans_model.dart';

class TerritoryExpansionManagerExpansionPlansNotifier extends StateNotifier<TerritoryExpansionManagerExpansionPlansModel> {
  TerritoryExpansionManagerExpansionPlansNotifier() : super(const TerritoryExpansionManagerExpansionPlansModel(isLoading: true));

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

final territory_expansion_manager_expansion_plansProvider = StateNotifierProvider<TerritoryExpansionManagerExpansionPlansNotifier, TerritoryExpansionManagerExpansionPlansModel>((ref) {
  return TerritoryExpansionManagerExpansionPlansNotifier()..loadData();
});
