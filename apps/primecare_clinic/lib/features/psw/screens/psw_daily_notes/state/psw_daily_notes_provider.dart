import 'package:flutter_riverpod/legacy.dart';
import '../models/psw_daily_notes_model.dart';

class PswDailyNotesNotifier extends StateNotifier<PswDailyNotesModel> {
  PswDailyNotesNotifier() : super(const PswDailyNotesModel(isLoading: true));

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

final psw_daily_notesProvider = StateNotifierProvider<PswDailyNotesNotifier, PswDailyNotesModel>((ref) {
  return PswDailyNotesNotifier()..loadData();
});
