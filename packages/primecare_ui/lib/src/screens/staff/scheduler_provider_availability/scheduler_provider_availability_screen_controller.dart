import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulerProviderAvailabilityScreenState
    extends DashboardState<SchedulerProviderAvailabilityScreenState> {
  SchedulerProviderAvailabilityScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  SchedulerProviderAvailabilityScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => SchedulerProviderAvailabilityScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class SchedulerProviderAvailabilityScreenController
    extends BaseDashboardController<SchedulerProviderAvailabilityScreenState> {
  SchedulerProviderAvailabilityScreenController(Ref ref)
    : super(
        ref,
        initialState: SchedulerProviderAvailabilityScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/staff/scheduler-provider-availability',
      );
}

final scheduler_provider_availabilityControllerProvider =
    StateNotifierProvider<
      SchedulerProviderAvailabilityScreenController,
      SchedulerProviderAvailabilityScreenState
    >((ref) {
      return SchedulerProviderAvailabilityScreenController(ref);
    });
