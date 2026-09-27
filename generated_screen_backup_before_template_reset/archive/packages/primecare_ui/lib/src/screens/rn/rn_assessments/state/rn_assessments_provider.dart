import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rn_assessments_model.dart';

class RnAssessmentsNotifier extends StateNotifier<RnAssessmentsModel> {
  RnAssessmentsNotifier() : super(const RnAssessmentsModel(isLoading: true));

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

final rn_assessmentsProvider = StateNotifierProvider<RnAssessmentsNotifier, RnAssessmentsModel>((ref) {
  return RnAssessmentsNotifier()..loadData();
});
