import 'package:flutter_riverpod/legacy.dart';
import '../models/territory_sales_manager_leads_model.dart';

class TerritorySalesManagerLeadsNotifier extends StateNotifier<TerritorySalesManagerLeadsModel> {
  TerritorySalesManagerLeadsNotifier() : super(const TerritorySalesManagerLeadsModel(isLoading: true));

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

final territory_sales_manager_leadsProvider = StateNotifierProvider<TerritorySalesManagerLeadsNotifier, TerritorySalesManagerLeadsModel>((ref) {
  return TerritorySalesManagerLeadsNotifier()..loadData();
});
