import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/board_of_directors_summary_model.dart';

class BoardOfDirectorsSummaryNotifier extends StateNotifier<BoardOfDirectorsSummaryModel> {
  BoardOfDirectorsSummaryNotifier() : super(const BoardOfDirectorsSummaryModel(isLoading: true));

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

final board_of_directors_summaryProvider = StateNotifierProvider<BoardOfDirectorsSummaryNotifier, BoardOfDirectorsSummaryModel>((ref) {
  return BoardOfDirectorsSummaryNotifier()..loadData();
});
