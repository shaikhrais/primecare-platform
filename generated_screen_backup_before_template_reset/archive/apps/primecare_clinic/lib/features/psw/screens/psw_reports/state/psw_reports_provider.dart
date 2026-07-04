import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/psw_reports_model.dart';

class PswReportsNotifier extends StateNotifier<PswReportsModel> {
  PswReportsNotifier() : super(const PswReportsModel(isLoading: true));

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

final psw_reportsProvider = StateNotifierProvider<PswReportsNotifier, PswReportsModel>((ref) {
  return PswReportsNotifier()..loadData();
});
