import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/incident_management_model.dart';

class IncidentManagementNotifier extends StateNotifier<IncidentManagementModel> {
  IncidentManagementNotifier() : super(const IncidentManagementModel(isLoading: true));

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

final incident_managementProvider = StateNotifierProvider<IncidentManagementNotifier, IncidentManagementModel>((ref) {
  return IncidentManagementNotifier()..loadData();
});
