import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/territory_sales_manager_competitors_model.dart';

class TerritorySalesManagerCompetitorsNotifier extends StateNotifier<TerritorySalesManagerCompetitorsModel> {
  TerritorySalesManagerCompetitorsNotifier() : super(const TerritorySalesManagerCompetitorsModel(isLoading: true));

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

final territory_sales_manager_competitorsProvider = StateNotifierProvider<TerritorySalesManagerCompetitorsNotifier, TerritorySalesManagerCompetitorsModel>((ref) {
  return TerritorySalesManagerCompetitorsNotifier()..loadData();
});
