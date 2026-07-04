import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/simulation_lab_scheduler_model.dart';

class SimulationLabSchedulerNotifier extends StateNotifier<SimulationLabSchedulerModel> {
  SimulationLabSchedulerNotifier() : super(const SimulationLabSchedulerModel(isLoading: true));

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

final simulation_lab_schedulerProvider = StateNotifierProvider<SimulationLabSchedulerNotifier, SimulationLabSchedulerModel>((ref) {
  return SimulationLabSchedulerNotifier()..loadData();
});
