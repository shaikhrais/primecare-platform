import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rmt_treatment_notes_model.dart';

class RmtTreatmentNotesNotifier extends StateNotifier<RmtTreatmentNotesModel> {
  RmtTreatmentNotesNotifier() : super(const RmtTreatmentNotesModel(isLoading: true));

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

final rmt_treatment_notesProvider = StateNotifierProvider<RmtTreatmentNotesNotifier, RmtTreatmentNotesModel>((ref) {
  return RmtTreatmentNotesNotifier()..loadData();
});
