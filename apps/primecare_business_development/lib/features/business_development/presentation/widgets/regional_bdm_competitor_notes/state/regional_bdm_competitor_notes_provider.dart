import 'package:flutter_riverpod/legacy.dart';
import '../models/regional_bdm_competitor_notes_model.dart';

class RegionalBdmCompetitorNotesNotifier extends StateNotifier<RegionalBdmCompetitorNotesModel> {
  RegionalBdmCompetitorNotesNotifier() : super(const RegionalBdmCompetitorNotesModel(isLoading: true));

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

final regional_bdm_competitor_notesProvider = StateNotifierProvider<RegionalBdmCompetitorNotesNotifier, RegionalBdmCompetitorNotesModel>((ref) {
  return RegionalBdmCompetitorNotesNotifier()..loadData();
});
