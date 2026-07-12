import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/caregiver_incident_report_model.dart';

class CaregiverIncidentReportNotifier extends StateNotifier<CaregiverIncidentReportModel> {
  CaregiverIncidentReportNotifier() : super(const CaregiverIncidentReportModel(isLoading: true));

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

final caregiver_incident_reportProvider = StateNotifierProvider<CaregiverIncidentReportNotifier, CaregiverIncidentReportModel>((ref) {
  return CaregiverIncidentReportNotifier()..loadData();
});
