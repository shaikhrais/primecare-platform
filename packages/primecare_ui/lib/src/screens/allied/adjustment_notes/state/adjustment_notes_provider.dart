import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/adjustment_notes_model.dart';

class AdjustmentNotesNotifier extends StateNotifier<AdjustmentNotesModel> {
  AdjustmentNotesNotifier() : super(const AdjustmentNotesModel(isLoading: true));

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

final adjustment_notesProvider = StateNotifierProvider<AdjustmentNotesNotifier, AdjustmentNotesModel>((ref) {
  return AdjustmentNotesNotifier()..loadData();
});
