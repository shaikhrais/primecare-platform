import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/scheduler_provider_availability_model.dart';

class SchedulerProviderAvailabilityNotifier extends StateNotifier<SchedulerProviderAvailabilityModel> {
  SchedulerProviderAvailabilityNotifier() : super(const SchedulerProviderAvailabilityModel(isLoading: true));

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

final scheduler_provider_availabilityProvider = StateNotifierProvider<SchedulerProviderAvailabilityNotifier, SchedulerProviderAvailabilityModel>((ref) {
  return SchedulerProviderAvailabilityNotifier()..loadData();
});
