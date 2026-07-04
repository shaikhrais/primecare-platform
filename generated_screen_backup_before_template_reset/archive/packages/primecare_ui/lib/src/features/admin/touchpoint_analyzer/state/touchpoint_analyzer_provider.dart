import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/touchpoint_analyzer_model.dart';

class TouchpointAnalyzerNotifier extends StateNotifier<TouchpointAnalyzerModel> {
  TouchpointAnalyzerNotifier() : super(const TouchpointAnalyzerModel(isLoading: true));

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

final touchpoint_analyzerProvider = StateNotifierProvider<TouchpointAnalyzerNotifier, TouchpointAnalyzerModel>((ref) {
  return TouchpointAnalyzerNotifier()..loadData();
});
