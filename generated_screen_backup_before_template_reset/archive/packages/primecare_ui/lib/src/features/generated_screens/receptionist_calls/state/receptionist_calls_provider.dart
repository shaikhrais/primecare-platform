import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/receptionist_calls_model.dart';

class ReceptionistCallsNotifier extends StateNotifier<ReceptionistCallsModel> {
  ReceptionistCallsNotifier() : super(const ReceptionistCallsModel(isLoading: true));

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

final receptionist_callsProvider = StateNotifierProvider<ReceptionistCallsNotifier, ReceptionistCallsModel>((ref) {
  return ReceptionistCallsNotifier()..loadData();
});
