import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulerBookingRequestsScreenState
    extends DashboardState<SchedulerBookingRequestsScreenState> {
  SchedulerBookingRequestsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  SchedulerBookingRequestsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => SchedulerBookingRequestsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class SchedulerBookingRequestsScreenController
    extends BaseDashboardController<SchedulerBookingRequestsScreenState> {
  SchedulerBookingRequestsScreenController(Ref ref)
    : super(
        ref,
        initialState: SchedulerBookingRequestsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/staff/scheduler-booking-requests',
      );
}

final scheduler_booking_requestsControllerProvider =
    StateNotifierProvider<
      SchedulerBookingRequestsScreenController,
      SchedulerBookingRequestsScreenState
    >((ref) {
      return SchedulerBookingRequestsScreenController(ref);
    });
