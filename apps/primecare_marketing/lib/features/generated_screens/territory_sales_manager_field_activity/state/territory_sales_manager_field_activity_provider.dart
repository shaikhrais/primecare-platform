import 'package:flutter_riverpod/legacy.dart';
import '../models/territory_sales_manager_field_activity_model.dart';

class TerritorySalesManagerFieldActivityNotifier extends StateNotifier<TerritorySalesManagerFieldActivityModel> {
  TerritorySalesManagerFieldActivityNotifier() : super(const TerritorySalesManagerFieldActivityModel(isLoading: true));

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

final territory_sales_manager_field_activityProvider = StateNotifierProvider<TerritorySalesManagerFieldActivityNotifier, TerritorySalesManagerFieldActivityModel>((ref) {
  return TerritorySalesManagerFieldActivityNotifier()..loadData();
});
