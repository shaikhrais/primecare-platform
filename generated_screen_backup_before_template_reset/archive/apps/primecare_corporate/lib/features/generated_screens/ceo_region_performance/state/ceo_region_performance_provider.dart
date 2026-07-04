import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ceo_region_performance_model.dart';

class CeoRegionPerformanceNotifier extends StateNotifier<CeoRegionPerformanceModel> {
  CeoRegionPerformanceNotifier() : super(const CeoRegionPerformanceModel(isLoading: true));

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

final ceo_region_performanceProvider = StateNotifierProvider<CeoRegionPerformanceNotifier, CeoRegionPerformanceModel>((ref) {
  return CeoRegionPerformanceNotifier()..loadData();
});
