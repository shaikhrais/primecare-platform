import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/competitor_analysis_board_model.dart';

class CompetitorAnalysisBoardNotifier extends StateNotifier<CompetitorAnalysisBoardModel> {
  CompetitorAnalysisBoardNotifier() : super(const CompetitorAnalysisBoardModel(isLoading: true));

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

final competitor_analysis_boardProvider = StateNotifierProvider<CompetitorAnalysisBoardNotifier, CompetitorAnalysisBoardModel>((ref) {
  return CompetitorAnalysisBoardNotifier()..loadData();
});
