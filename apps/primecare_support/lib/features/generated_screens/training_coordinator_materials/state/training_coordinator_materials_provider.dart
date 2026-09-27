import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/training_coordinator_materials_model.dart';

class TrainingCoordinatorMaterialsNotifier extends StateNotifier<TrainingCoordinatorMaterialsModel> {
  TrainingCoordinatorMaterialsNotifier() : super(const TrainingCoordinatorMaterialsModel(isLoading: true));

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

final training_coordinator_materialsProvider = StateNotifierProvider<TrainingCoordinatorMaterialsNotifier, TrainingCoordinatorMaterialsModel>((ref) {
  return TrainingCoordinatorMaterialsNotifier()..loadData();
});
