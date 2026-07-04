import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/staff_utilization_heatmap_model.dart';

class StaffUtilizationHeatmapNotifier extends StateNotifier<StaffUtilizationHeatmapModel> {
  StaffUtilizationHeatmapNotifier() : super(const StaffUtilizationHeatmapModel(isLoading: true));

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

final staff_utilization_heatmapProvider = StateNotifierProvider<StaffUtilizationHeatmapNotifier, StaffUtilizationHeatmapModel>((ref) {
  return StaffUtilizationHeatmapNotifier()..loadData();
});
