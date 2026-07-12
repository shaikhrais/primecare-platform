import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rmt_reports_model.dart';

class RmtReportsNotifier extends StateNotifier<RmtReportsModel> {
  RmtReportsNotifier() : super(const RmtReportsModel(isLoading: true));

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

final rmt_reportsProvider = StateNotifierProvider<RmtReportsNotifier, RmtReportsModel>((ref) {
  return RmtReportsNotifier()..loadData();
});
