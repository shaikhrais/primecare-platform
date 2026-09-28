import 'package:flutter_riverpod/legacy.dart';
import '../models/staff_training_matrix_model.dart';

class StaffTrainingMatrixNotifier extends StateNotifier<StaffTrainingMatrixModel> {
  StaffTrainingMatrixNotifier() : super(const StaffTrainingMatrixModel(isLoading: true));

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

final staff_training_matrixProvider = StateNotifierProvider<StaffTrainingMatrixNotifier, StaffTrainingMatrixModel>((ref) {
  return StaffTrainingMatrixNotifier()..loadData();
});
