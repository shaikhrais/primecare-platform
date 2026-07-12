import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/architecture_planning_compliance_model.dart';

class ArchitecturePlanningComplianceNotifier extends StateNotifier<ArchitecturePlanningComplianceModel> {
  ArchitecturePlanningComplianceNotifier() : super(const ArchitecturePlanningComplianceModel(isLoading: true));

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

final architecture_planning_complianceProvider = StateNotifierProvider<ArchitecturePlanningComplianceNotifier, ArchitecturePlanningComplianceModel>((ref) {
  return ArchitecturePlanningComplianceNotifier()..loadData();
});
