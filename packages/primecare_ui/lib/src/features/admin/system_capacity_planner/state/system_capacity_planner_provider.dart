import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/system_capacity_planner_model.dart';

class SystemCapacityPlannerNotifier extends StateNotifier<SystemCapacityPlannerModel> {
  SystemCapacityPlannerNotifier() : super(const SystemCapacityPlannerModel(isLoading: true));

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

final system_capacity_plannerProvider = StateNotifierProvider<SystemCapacityPlannerNotifier, SystemCapacityPlannerModel>((ref) {
  return SystemCapacityPlannerNotifier()..loadData();
});
