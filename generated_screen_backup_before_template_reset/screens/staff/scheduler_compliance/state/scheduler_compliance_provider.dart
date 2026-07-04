import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/scheduler_compliance_model.dart';

class SchedulerComplianceNotifier extends StateNotifier<SchedulerComplianceModel> {
  SchedulerComplianceNotifier() : super(const SchedulerComplianceModel(isLoading: true));

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

final scheduler_complianceProvider = StateNotifierProvider<SchedulerComplianceNotifier, SchedulerComplianceModel>((ref) {
  return SchedulerComplianceNotifier()..loadData();
});
