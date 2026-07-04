import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/environmental_health_hazards_model.dart';

class EnvironmentalHealthHazardsNotifier extends StateNotifier<EnvironmentalHealthHazardsModel> {
  EnvironmentalHealthHazardsNotifier() : super(const EnvironmentalHealthHazardsModel(isLoading: true));

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

final environmental_health_hazardsProvider = StateNotifierProvider<EnvironmentalHealthHazardsNotifier, EnvironmentalHealthHazardsModel>((ref) {
  return EnvironmentalHealthHazardsNotifier()..loadData();
});
