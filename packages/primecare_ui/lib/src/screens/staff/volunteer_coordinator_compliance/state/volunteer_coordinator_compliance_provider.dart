import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/volunteer_coordinator_compliance_model.dart';

class VolunteerCoordinatorComplianceNotifier extends StateNotifier<VolunteerCoordinatorComplianceModel> {
  VolunteerCoordinatorComplianceNotifier() : super(const VolunteerCoordinatorComplianceModel(isLoading: true));

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

final volunteer_coordinator_complianceProvider = StateNotifierProvider<VolunteerCoordinatorComplianceNotifier, VolunteerCoordinatorComplianceModel>((ref) {
  return VolunteerCoordinatorComplianceNotifier()..loadData();
});
