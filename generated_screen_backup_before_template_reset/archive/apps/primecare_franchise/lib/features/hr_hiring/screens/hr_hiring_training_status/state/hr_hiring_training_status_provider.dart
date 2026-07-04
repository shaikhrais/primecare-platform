import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hr_hiring_training_status_model.dart';

class HrHiringTrainingStatusNotifier extends StateNotifier<HrHiringTrainingStatusModel> {
  HrHiringTrainingStatusNotifier() : super(const HrHiringTrainingStatusModel(isLoading: true));

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

final hr_hiring_training_statusProvider = StateNotifierProvider<HrHiringTrainingStatusNotifier, HrHiringTrainingStatusModel>((ref) {
  return HrHiringTrainingStatusNotifier()..loadData();
});
