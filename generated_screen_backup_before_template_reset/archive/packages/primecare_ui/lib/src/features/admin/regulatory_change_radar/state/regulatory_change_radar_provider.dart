import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/regulatory_change_radar_model.dart';

class RegulatoryChangeRadarNotifier extends StateNotifier<RegulatoryChangeRadarModel> {
  RegulatoryChangeRadarNotifier() : super(const RegulatoryChangeRadarModel(isLoading: true));

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

final regulatory_change_radarProvider = StateNotifierProvider<RegulatoryChangeRadarNotifier, RegulatoryChangeRadarModel>((ref) {
  return RegulatoryChangeRadarNotifier()..loadData();
});
