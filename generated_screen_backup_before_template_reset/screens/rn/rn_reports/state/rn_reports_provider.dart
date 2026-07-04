import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rn_reports_model.dart';

class RnReportsNotifier extends StateNotifier<RnReportsModel> {
  RnReportsNotifier() : super(const RnReportsModel(isLoading: true));

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

final rn_reportsProvider = StateNotifierProvider<RnReportsNotifier, RnReportsModel>((ref) {
  return RnReportsNotifier()..loadData();
});
