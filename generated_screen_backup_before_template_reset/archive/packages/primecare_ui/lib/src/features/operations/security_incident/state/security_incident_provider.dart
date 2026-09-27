import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/security_incident_model.dart';

class SecurityIncidentNotifier extends StateNotifier<SecurityIncidentModel> {
  SecurityIncidentNotifier() : super(const SecurityIncidentModel(isLoading: true));

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

final security_incidentProvider = StateNotifierProvider<SecurityIncidentNotifier, SecurityIncidentModel>((ref) {
  return SecurityIncidentNotifier()..loadData();
});
