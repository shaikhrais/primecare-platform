import 'package:flutter_riverpod/legacy.dart';
import '../models/cfo_reports_model.dart';

class CfoReportsNotifier extends StateNotifier<CfoReportsModel> {
  CfoReportsNotifier() : super(const CfoReportsModel(isLoading: true));

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

final cfo_reportsProvider = StateNotifierProvider<CfoReportsNotifier, CfoReportsModel>((ref) {
  return CfoReportsNotifier()..loadData();
});
