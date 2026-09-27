import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/physiotherapist_analytics_model.dart';

class PhysiotherapistAnalyticsNotifier extends StateNotifier<PhysiotherapistAnalyticsModel> {
  PhysiotherapistAnalyticsNotifier() : super(const PhysiotherapistAnalyticsModel(isLoading: true));

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

final physiotherapist_analyticsProvider = StateNotifierProvider<PhysiotherapistAnalyticsNotifier, PhysiotherapistAnalyticsModel>((ref) {
  return PhysiotherapistAnalyticsNotifier()..loadData();
});
