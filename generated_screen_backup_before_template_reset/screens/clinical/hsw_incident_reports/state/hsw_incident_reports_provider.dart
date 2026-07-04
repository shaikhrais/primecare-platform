import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hsw_incident_reports_model.dart';

class HswIncidentReportsNotifier extends StateNotifier<HswIncidentReportsModel> {
  HswIncidentReportsNotifier() : super(const HswIncidentReportsModel(isLoading: true));

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

final hsw_incident_reportsProvider = StateNotifierProvider<HswIncidentReportsNotifier, HswIncidentReportsModel>((ref) {
  return HswIncidentReportsNotifier()..loadData();
});
