import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/shareholder_analytics_model.dart';

class ShareholderAnalyticsNotifier extends StateNotifier<ShareholderAnalyticsModel> {
  ShareholderAnalyticsNotifier() : super(const ShareholderAnalyticsModel(isLoading: true));

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

final shareholder_analyticsProvider = StateNotifierProvider<ShareholderAnalyticsNotifier, ShareholderAnalyticsModel>((ref) {
  return ShareholderAnalyticsNotifier()..loadData();
});
