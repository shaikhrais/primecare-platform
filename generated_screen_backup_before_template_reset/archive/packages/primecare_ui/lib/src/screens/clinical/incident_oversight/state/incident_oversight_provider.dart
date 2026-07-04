import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/incident_oversight_model.dart';

class IncidentOversightNotifier extends StateNotifier<IncidentOversightModel> {
  IncidentOversightNotifier() : super(const IncidentOversightModel(isLoading: true));

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

final incident_oversightProvider = StateNotifierProvider<IncidentOversightNotifier, IncidentOversightModel>((ref) {
  return IncidentOversightNotifier()..loadData();
});
