import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/scheduling_health_model.dart';

class SchedulingHealthNotifier extends StateNotifier<SchedulingHealthModel> {
  SchedulingHealthNotifier() : super(const SchedulingHealthModel(isLoading: true));

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

final scheduling_healthProvider = StateNotifierProvider<SchedulingHealthNotifier, SchedulingHealthModel>((ref) {
  return SchedulingHealthNotifier()..loadData();
});
