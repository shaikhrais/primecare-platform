import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hr_hiring_reports_model.dart';

class HrHiringReportsNotifier extends StateNotifier<HrHiringReportsModel> {
  HrHiringReportsNotifier() : super(const HrHiringReportsModel(isLoading: true));

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

final hr_hiring_reportsProvider = StateNotifierProvider<HrHiringReportsNotifier, HrHiringReportsModel>((ref) {
  return HrHiringReportsNotifier()..loadData();
});
