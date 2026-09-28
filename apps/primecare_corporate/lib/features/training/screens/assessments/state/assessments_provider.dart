import 'package:flutter_riverpod/legacy.dart';
import '../models/assessments_model.dart';

class AssessmentsNotifier extends StateNotifier<AssessmentsModel> {
  AssessmentsNotifier() : super(const AssessmentsModel(isLoading: true));

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

final assessmentsProvider = StateNotifierProvider<AssessmentsNotifier, AssessmentsModel>((ref) {
  return AssessmentsNotifier()..loadData();
});
