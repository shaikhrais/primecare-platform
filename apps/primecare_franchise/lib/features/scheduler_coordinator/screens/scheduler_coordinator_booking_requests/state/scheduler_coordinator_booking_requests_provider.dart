import 'package:flutter_riverpod/legacy.dart';
import '../models/scheduler_coordinator_booking_requests_model.dart';

class SchedulerCoordinatorBookingRequestsNotifier extends StateNotifier<SchedulerCoordinatorBookingRequestsModel> {
  SchedulerCoordinatorBookingRequestsNotifier() : super(const SchedulerCoordinatorBookingRequestsModel(isLoading: true));

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

final scheduler_coordinator_booking_requestsProvider = StateNotifierProvider<SchedulerCoordinatorBookingRequestsNotifier, SchedulerCoordinatorBookingRequestsModel>((ref) {
  return SchedulerCoordinatorBookingRequestsNotifier()..loadData();
});
