import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoordinatorDispatchMapScreenState
    extends DashboardState<CoordinatorDispatchMapScreenState> {
  CoordinatorDispatchMapScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CoordinatorDispatchMapScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CoordinatorDispatchMapScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CoordinatorDispatchMapScreenController
    extends BaseDashboardController<CoordinatorDispatchMapScreenState> {
  CoordinatorDispatchMapScreenController(Ref ref)
    : super(
        ref,
        initialState: CoordinatorDispatchMapScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/staff/coordinator-dispatch-map',
      );
}

final coordinator_dispatch_mapControllerProvider =
    StateNotifierProvider<
      CoordinatorDispatchMapScreenController,
      CoordinatorDispatchMapScreenState
    >((ref) {
      return CoordinatorDispatchMapScreenController(ref);
    });
