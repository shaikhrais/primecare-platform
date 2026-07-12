import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/qa_analytics_model.dart';

class QaAnalyticsNotifier extends StateNotifier<QaAnalyticsModel> {
  QaAnalyticsNotifier() : super(const QaAnalyticsModel(isLoading: true));

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

final qa_analyticsProvider = StateNotifierProvider<QaAnalyticsNotifier, QaAnalyticsModel>((ref) {
  return QaAnalyticsNotifier()..loadData();
});
