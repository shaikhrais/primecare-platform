import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeCoordinatorBookingScreenState
    extends DashboardState<IntakeCoordinatorBookingScreenState> {
  IntakeCoordinatorBookingScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  IntakeCoordinatorBookingScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => IntakeCoordinatorBookingScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class IntakeCoordinatorBookingScreenController
    extends BaseDashboardController<IntakeCoordinatorBookingScreenState> {
  IntakeCoordinatorBookingScreenController(Ref ref)
    : super(
        ref,
        initialState: IntakeCoordinatorBookingScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/executive/intake-coordinator-booking',
      );
}

final intake_coordinator_bookingControllerProvider =
    StateNotifierProvider<
      IntakeCoordinatorBookingScreenController,
      IntakeCoordinatorBookingScreenState
    >((ref) {
      return IntakeCoordinatorBookingScreenController(ref);
    });
