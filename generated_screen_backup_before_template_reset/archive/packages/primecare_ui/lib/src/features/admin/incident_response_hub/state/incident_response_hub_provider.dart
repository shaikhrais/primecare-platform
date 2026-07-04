import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/incident_response_hub_model.dart';

class IncidentResponseHubNotifier extends StateNotifier<IncidentResponseHubModel> {
  IncidentResponseHubNotifier() : super(const IncidentResponseHubModel(isLoading: true));

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

final incident_response_hubProvider = StateNotifierProvider<IncidentResponseHubNotifier, IncidentResponseHubModel>((ref) {
  return IncidentResponseHubNotifier()..loadData();
});
