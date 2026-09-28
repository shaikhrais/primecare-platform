import 'package:flutter_riverpod/legacy.dart';
import '../models/client_treatment_history_model.dart';

class ClientTreatmentHistoryNotifier extends StateNotifier<ClientTreatmentHistoryModel> {
  ClientTreatmentHistoryNotifier() : super(const ClientTreatmentHistoryModel(isLoading: true));

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

final client_treatment_historyProvider = StateNotifierProvider<ClientTreatmentHistoryNotifier, ClientTreatmentHistoryModel>((ref) {
  return ClientTreatmentHistoryNotifier()..loadData();
});
