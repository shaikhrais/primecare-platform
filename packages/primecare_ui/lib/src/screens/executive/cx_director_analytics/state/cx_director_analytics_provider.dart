import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cx_director_analytics_model.dart';

class CxDirectorAnalyticsNotifier extends StateNotifier<CxDirectorAnalyticsModel> {
  CxDirectorAnalyticsNotifier() : super(const CxDirectorAnalyticsModel(isLoading: true));

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

final cx_director_analyticsProvider = StateNotifierProvider<CxDirectorAnalyticsNotifier, CxDirectorAnalyticsModel>((ref) {
  return CxDirectorAnalyticsNotifier()..loadData();
});
