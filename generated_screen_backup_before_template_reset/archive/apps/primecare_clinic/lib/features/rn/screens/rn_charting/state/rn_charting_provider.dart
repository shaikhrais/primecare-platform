import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rn_charting_model.dart';

class RnChartingNotifier extends StateNotifier<RnChartingModel> {
  RnChartingNotifier() : super(const RnChartingModel(isLoading: true));

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

final rn_chartingProvider = StateNotifierProvider<RnChartingNotifier, RnChartingModel>((ref) {
  return RnChartingNotifier()..loadData();
});
