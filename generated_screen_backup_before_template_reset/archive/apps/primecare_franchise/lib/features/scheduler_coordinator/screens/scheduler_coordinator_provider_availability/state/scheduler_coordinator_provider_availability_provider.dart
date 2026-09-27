import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/scheduler_coordinator_provider_availability_model.dart';

class SchedulerCoordinatorProviderAvailabilityNotifier extends StateNotifier<SchedulerCoordinatorProviderAvailabilityModel> {
  SchedulerCoordinatorProviderAvailabilityNotifier() : super(const SchedulerCoordinatorProviderAvailabilityModel(isLoading: true));

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

final scheduler_coordinator_provider_availabilityProvider = StateNotifierProvider<SchedulerCoordinatorProviderAvailabilityNotifier, SchedulerCoordinatorProviderAvailabilityModel>((ref) {
  return SchedulerCoordinatorProviderAvailabilityNotifier()..loadData();
});
