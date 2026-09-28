import 'package:flutter_riverpod/legacy.dart';
import '../models/ceo_alerts_and_risks_model.dart';

class CeoAlertsAndRisksNotifier extends StateNotifier<CeoAlertsAndRisksModel> {
  CeoAlertsAndRisksNotifier() : super(const CeoAlertsAndRisksModel(isLoading: true));

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

final ceo_alerts_and_risksProvider = StateNotifierProvider<CeoAlertsAndRisksNotifier, CeoAlertsAndRisksModel>((ref) {
  return CeoAlertsAndRisksNotifier()..loadData();
});
