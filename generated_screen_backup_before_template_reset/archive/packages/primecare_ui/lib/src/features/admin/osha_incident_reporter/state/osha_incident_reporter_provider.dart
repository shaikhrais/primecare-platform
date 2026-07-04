import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/osha_incident_reporter_model.dart';

class OshaIncidentReporterNotifier extends StateNotifier<OshaIncidentReporterModel> {
  OshaIncidentReporterNotifier() : super(const OshaIncidentReporterModel(isLoading: true));

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

final osha_incident_reporterProvider = StateNotifierProvider<OshaIncidentReporterNotifier, OshaIncidentReporterModel>((ref) {
  return OshaIncidentReporterNotifier()..loadData();
});
