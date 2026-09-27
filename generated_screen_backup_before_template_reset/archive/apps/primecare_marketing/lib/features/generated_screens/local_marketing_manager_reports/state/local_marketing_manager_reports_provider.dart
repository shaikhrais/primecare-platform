import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/local_marketing_manager_reports_model.dart';

class LocalMarketingManagerReportsNotifier extends StateNotifier<LocalMarketingManagerReportsModel> {
  LocalMarketingManagerReportsNotifier() : super(const LocalMarketingManagerReportsModel(isLoading: true));

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

final local_marketing_manager_reportsProvider = StateNotifierProvider<LocalMarketingManagerReportsNotifier, LocalMarketingManagerReportsModel>((ref) {
  return LocalMarketingManagerReportsNotifier()..loadData();
});
