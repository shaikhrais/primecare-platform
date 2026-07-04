import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/territory_sales_mapping_model.dart';

class TerritorySalesMappingNotifier extends StateNotifier<TerritorySalesMappingModel> {
  TerritorySalesMappingNotifier() : super(const TerritorySalesMappingModel(isLoading: true));

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

final territory_sales_mappingProvider = StateNotifierProvider<TerritorySalesMappingNotifier, TerritorySalesMappingModel>((ref) {
  return TerritorySalesMappingNotifier()..loadData();
});
