import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoordinatorWaitlistScreenState
    extends DashboardState<CoordinatorWaitlistScreenState> {
  CoordinatorWaitlistScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CoordinatorWaitlistScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CoordinatorWaitlistScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CoordinatorWaitlistScreenController
    extends BaseDashboardController<CoordinatorWaitlistScreenState> {
  CoordinatorWaitlistScreenController(Ref ref)
    : super(
        ref,
        initialState: CoordinatorWaitlistScreenState(isLoading: true, data: {}),
        endpoint: '/staff/coordinator-waitlist',
      );
}

final coordinator_waitlistControllerProvider =
    StateNotifierProvider<
      CoordinatorWaitlistScreenController,
      CoordinatorWaitlistScreenState
    >((ref) {
      return CoordinatorWaitlistScreenController(ref);
    });
