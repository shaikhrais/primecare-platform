import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/psw_incident_report_model.dart';

class PswIncidentReportNotifier extends StateNotifier<PswIncidentReportModel> {
  PswIncidentReportNotifier() : super(const PswIncidentReportModel(isLoading: true));

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

final psw_incident_reportProvider = StateNotifierProvider<PswIncidentReportNotifier, PswIncidentReportModel>((ref) {
  return PswIncidentReportNotifier()..loadData();
});
