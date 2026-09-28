import 'package:flutter_riverpod/legacy.dart';
import '../models/intake_coordinator_reports_model.dart';

class IntakeCoordinatorReportsNotifier extends StateNotifier<IntakeCoordinatorReportsModel> {
  IntakeCoordinatorReportsNotifier() : super(const IntakeCoordinatorReportsModel(isLoading: true));

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

final intake_coordinator_reportsProvider = StateNotifierProvider<IntakeCoordinatorReportsNotifier, IntakeCoordinatorReportsModel>((ref) {
  return IntakeCoordinatorReportsNotifier()..loadData();
});
