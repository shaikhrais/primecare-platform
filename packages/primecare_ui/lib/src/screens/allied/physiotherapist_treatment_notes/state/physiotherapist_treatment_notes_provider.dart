import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/physiotherapist_treatment_notes_model.dart';

class PhysiotherapistTreatmentNotesNotifier extends StateNotifier<PhysiotherapistTreatmentNotesModel> {
  PhysiotherapistTreatmentNotesNotifier() : super(const PhysiotherapistTreatmentNotesModel(isLoading: true));

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

final physiotherapist_treatment_notesProvider = StateNotifierProvider<PhysiotherapistTreatmentNotesNotifier, PhysiotherapistTreatmentNotesModel>((ref) {
  return PhysiotherapistTreatmentNotesNotifier()..loadData();
});
