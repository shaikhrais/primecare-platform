import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/clinic_incident_report_model.dart';

class ClinicIncidentReportNotifier extends StateNotifier<ClinicIncidentReportModel> {
  ClinicIncidentReportNotifier() : super(const ClinicIncidentReportModel(isLoading: true));

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

final clinic_incident_reportProvider = StateNotifierProvider<ClinicIncidentReportNotifier, ClinicIncidentReportModel>((ref) {
  return ClinicIncidentReportNotifier()..loadData();
});
