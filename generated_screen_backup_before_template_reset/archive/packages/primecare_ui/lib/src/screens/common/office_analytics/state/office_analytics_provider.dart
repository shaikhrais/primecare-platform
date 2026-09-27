import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/office_analytics_model.dart';

class OfficeAnalyticsNotifier extends StateNotifier<OfficeAnalyticsModel> {
  OfficeAnalyticsNotifier() : super(const OfficeAnalyticsModel(isLoading: true));

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

final office_analyticsProvider = StateNotifierProvider<OfficeAnalyticsNotifier, OfficeAnalyticsModel>((ref) {
  return OfficeAnalyticsNotifier()..loadData();
});
