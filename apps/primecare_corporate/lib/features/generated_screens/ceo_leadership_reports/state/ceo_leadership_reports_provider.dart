import 'package:flutter_riverpod/legacy.dart';
import '../models/ceo_leadership_reports_model.dart';

class CeoLeadershipReportsNotifier extends StateNotifier<CeoLeadershipReportsModel> {
  CeoLeadershipReportsNotifier() : super(const CeoLeadershipReportsModel(isLoading: true));

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

final ceo_leadership_reportsProvider = StateNotifierProvider<CeoLeadershipReportsNotifier, CeoLeadershipReportsModel>((ref) {
  return CeoLeadershipReportsNotifier()..loadData();
});
