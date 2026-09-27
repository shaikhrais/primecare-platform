import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/testing_overview_model.dart';

class TestingOverviewNotifier extends StateNotifier<TestingOverviewModel> {
  TestingOverviewNotifier() : super(const TestingOverviewModel(isLoading: true));

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

final testing_overviewProvider = StateNotifierProvider<TestingOverviewNotifier, TestingOverviewModel>((ref) {
  return TestingOverviewNotifier()..loadData();
});
