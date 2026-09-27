import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rn_patient_charting_model.dart';

class RnPatientChartingNotifier extends StateNotifier<RnPatientChartingModel> {
  RnPatientChartingNotifier() : super(const RnPatientChartingModel(isLoading: true));

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

final rn_patient_chartingProvider = StateNotifierProvider<RnPatientChartingNotifier, RnPatientChartingModel>((ref) {
  return RnPatientChartingNotifier()..loadData();
});
