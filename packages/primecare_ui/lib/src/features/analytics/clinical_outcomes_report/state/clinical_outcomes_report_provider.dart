import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/clinical_outcomes_report_model.dart';

class ClinicalOutcomesReportNotifier extends StateNotifier<ClinicalOutcomesReportModel> {
  ClinicalOutcomesReportNotifier() : super(const ClinicalOutcomesReportModel(isLoading: true));

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

final clinical_outcomes_reportProvider = StateNotifierProvider<ClinicalOutcomesReportNotifier, ClinicalOutcomesReportModel>((ref) {
  return ClinicalOutcomesReportNotifier()..loadData();
});
