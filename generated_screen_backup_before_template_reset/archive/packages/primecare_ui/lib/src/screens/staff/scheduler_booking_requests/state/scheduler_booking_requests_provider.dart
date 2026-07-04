import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/scheduler_booking_requests_model.dart';

class SchedulerBookingRequestsNotifier extends StateNotifier<SchedulerBookingRequestsModel> {
  SchedulerBookingRequestsNotifier() : super(const SchedulerBookingRequestsModel(isLoading: true));

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

final scheduler_booking_requestsProvider = StateNotifierProvider<SchedulerBookingRequestsNotifier, SchedulerBookingRequestsModel>((ref) {
  return SchedulerBookingRequestsNotifier()..loadData();
});
