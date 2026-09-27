import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/psw_visit_notes_model.dart';

class PswVisitNotesNotifier extends StateNotifier<PswVisitNotesModel> {
  PswVisitNotesNotifier() : super(const PswVisitNotesModel(isLoading: true));

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

final psw_visit_notesProvider = StateNotifierProvider<PswVisitNotesNotifier, PswVisitNotesModel>((ref) {
  return PswVisitNotesNotifier()..loadData();
});
