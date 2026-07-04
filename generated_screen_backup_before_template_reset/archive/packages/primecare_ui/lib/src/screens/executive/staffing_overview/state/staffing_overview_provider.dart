import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/staffing_overview_model.dart';

class StaffingOverviewNotifier extends StateNotifier<StaffingOverviewModel> {
  StaffingOverviewNotifier() : super(const StaffingOverviewModel(isLoading: true));

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

final staffing_overviewProvider = StateNotifierProvider<StaffingOverviewNotifier, StaffingOverviewModel>((ref) {
  return StaffingOverviewNotifier()..loadData();
});
