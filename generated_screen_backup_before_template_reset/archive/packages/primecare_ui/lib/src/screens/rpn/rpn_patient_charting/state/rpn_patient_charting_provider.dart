import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rpn_patient_charting_model.dart';

class RpnPatientChartingNotifier extends StateNotifier<RpnPatientChartingModel> {
  RpnPatientChartingNotifier() : super(const RpnPatientChartingModel(isLoading: true));

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

final rpn_patient_chartingProvider = StateNotifierProvider<RpnPatientChartingNotifier, RpnPatientChartingModel>((ref) {
  return RpnPatientChartingNotifier()..loadData();
});
