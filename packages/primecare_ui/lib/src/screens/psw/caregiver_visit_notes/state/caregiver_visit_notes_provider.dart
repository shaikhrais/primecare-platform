import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/caregiver_visit_notes_model.dart';

class CaregiverVisitNotesNotifier extends StateNotifier<CaregiverVisitNotesModel> {
  CaregiverVisitNotesNotifier() : super(const CaregiverVisitNotesModel(isLoading: true));

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

final caregiver_visit_notesProvider = StateNotifierProvider<CaregiverVisitNotesNotifier, CaregiverVisitNotesModel>((ref) {
  return CaregiverVisitNotesNotifier()..loadData();
});
