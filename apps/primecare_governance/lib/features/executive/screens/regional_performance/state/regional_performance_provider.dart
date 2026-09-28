import 'package:flutter_riverpod/legacy.dart';
import '../models/regional_performance_model.dart';

class RegionalPerformanceNotifier extends StateNotifier<RegionalPerformanceModel> {
  RegionalPerformanceNotifier() : super(const RegionalPerformanceModel(isLoading: true));

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

final regional_performanceProvider = StateNotifierProvider<RegionalPerformanceNotifier, RegionalPerformanceModel>((ref) {
  return RegionalPerformanceNotifier()..loadData();
});
