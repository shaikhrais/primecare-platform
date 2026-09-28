import 'package:flutter_riverpod/legacy.dart';
import '../models/psw_check_in_model.dart';

class PswCheckInNotifier extends StateNotifier<PswCheckInModel> {
  PswCheckInNotifier() : super(const PswCheckInModel(isLoading: true));

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

final psw_check_inProvider = StateNotifierProvider<PswCheckInNotifier, PswCheckInModel>((ref) {
  return PswCheckInNotifier()..loadData();
});
