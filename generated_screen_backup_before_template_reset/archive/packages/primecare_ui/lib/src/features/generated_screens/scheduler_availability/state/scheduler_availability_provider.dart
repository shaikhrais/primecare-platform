import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/scheduler_availability_model.dart';

class SchedulerAvailabilityNotifier extends StateNotifier<SchedulerAvailabilityModel> {
  SchedulerAvailabilityNotifier() : super(const SchedulerAvailabilityModel(isLoading: true));

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

final scheduler_availabilityProvider = StateNotifierProvider<SchedulerAvailabilityNotifier, SchedulerAvailabilityModel>((ref) {
  return SchedulerAvailabilityNotifier()..loadData();
});
