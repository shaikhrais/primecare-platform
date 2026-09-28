import 'package:flutter_riverpod/legacy.dart';
import '../models/incident_reports_model.dart';

class IncidentReportsNotifier extends StateNotifier<IncidentReportsModel> {
  IncidentReportsNotifier() : super(const IncidentReportsModel(isLoading: true));

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

final incident_reportsProvider = StateNotifierProvider<IncidentReportsNotifier, IncidentReportsModel>((ref) {
  return IncidentReportsNotifier()..loadData();
});
