import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoordinatorHubScreenState
    extends DashboardState<CoordinatorHubScreenState> {
  CoordinatorHubScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CoordinatorHubScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      CoordinatorHubScreenState(isLoading: isLoading, error: error, data: data);
}

class CoordinatorHubScreenController
    extends BaseDashboardController<CoordinatorHubScreenState> {
  CoordinatorHubScreenController(Ref ref)
    : super(
        ref,
        initialState: CoordinatorHubScreenState(isLoading: true, data: {}),
        endpoint: '/staff/coordinator-hub',
      );
}

final coordinator_hubControllerProvider =
    StateNotifierProvider<
      CoordinatorHubScreenController,
      CoordinatorHubScreenState
    >((ref) {
      return CoordinatorHubScreenController(ref);
    });
