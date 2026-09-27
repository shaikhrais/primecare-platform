import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/leadership_reports_model.dart';

class LeadershipReportsNotifier extends StateNotifier<LeadershipReportsModel> {
  LeadershipReportsNotifier() : super(const LeadershipReportsModel(isLoading: true));

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

final leadership_reportsProvider = StateNotifierProvider<LeadershipReportsNotifier, LeadershipReportsModel>((ref) {
  return LeadershipReportsNotifier()..loadData();
});
