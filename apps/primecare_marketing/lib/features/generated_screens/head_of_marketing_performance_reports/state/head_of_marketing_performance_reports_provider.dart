import 'package:flutter_riverpod/legacy.dart';
import '../models/head_of_marketing_performance_reports_model.dart';

class HeadOfMarketingPerformanceReportsNotifier extends StateNotifier<HeadOfMarketingPerformanceReportsModel> {
  HeadOfMarketingPerformanceReportsNotifier() : super(const HeadOfMarketingPerformanceReportsModel(isLoading: true));

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

final head_of_marketing_performance_reportsProvider = StateNotifierProvider<HeadOfMarketingPerformanceReportsNotifier, HeadOfMarketingPerformanceReportsModel>((ref) {
  return HeadOfMarketingPerformanceReportsNotifier()..loadData();
});
