import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/marketing_r_o_i_report_model.dart';

class MarketingROIReportNotifier extends StateNotifier<MarketingROIReportModel> {
  MarketingROIReportNotifier() : super(const MarketingROIReportModel(isLoading: true));

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

final marketing_r_o_i_reportProvider = StateNotifierProvider<MarketingROIReportNotifier, MarketingROIReportModel>((ref) {
  return MarketingROIReportNotifier()..loadData();
});
