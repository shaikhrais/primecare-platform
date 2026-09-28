import 'package:flutter_riverpod/legacy.dart';
import '../models/ceo_revenue_summary_model.dart';

class CeoRevenueSummaryNotifier extends StateNotifier<CeoRevenueSummaryModel> {
  CeoRevenueSummaryNotifier() : super(const CeoRevenueSummaryModel(isLoading: true));

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

final ceo_revenue_summaryProvider = StateNotifierProvider<CeoRevenueSummaryNotifier, CeoRevenueSummaryModel>((ref) {
  return CeoRevenueSummaryNotifier()..loadData();
});
