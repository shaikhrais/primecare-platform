import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/staff_performance_model.dart';

class StaffPerformanceNotifier extends StateNotifier<StaffPerformanceModel> {
  StaffPerformanceNotifier() : super(const StaffPerformanceModel(isLoading: true));

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

final staff_performanceProvider = StateNotifierProvider<StaffPerformanceNotifier, StaffPerformanceModel>((ref) {
  return StaffPerformanceNotifier()..loadData();
});
