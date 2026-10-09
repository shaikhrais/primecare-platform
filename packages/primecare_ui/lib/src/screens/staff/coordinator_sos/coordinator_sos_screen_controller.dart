import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoordinatorSosScreenState
    extends DashboardState<CoordinatorSosScreenState> {
  CoordinatorSosScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CoordinatorSosScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      CoordinatorSosScreenState(isLoading: isLoading, error: error, data: data);
}

class CoordinatorSosScreenController
    extends BaseDashboardController<CoordinatorSosScreenState> {
  CoordinatorSosScreenController(Ref ref)
    : super(
        ref,
        initialState: CoordinatorSosScreenState(isLoading: true, data: {}),
        endpoint: '/staff/coordinator-sos',
      );
}

final coordinator_sosControllerProvider =
    StateNotifierProvider<
      CoordinatorSosScreenController,
      CoordinatorSosScreenState
    >((ref) {
      return CoordinatorSosScreenController(ref);
    });
