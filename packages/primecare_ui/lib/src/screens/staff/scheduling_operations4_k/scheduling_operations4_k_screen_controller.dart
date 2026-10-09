import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulingOperations4KScreenState
    extends DashboardState<SchedulingOperations4KScreenState> {
  SchedulingOperations4KScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  SchedulingOperations4KScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => SchedulingOperations4KScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class SchedulingOperations4KScreenController
    extends BaseDashboardController<SchedulingOperations4KScreenState> {
  SchedulingOperations4KScreenController(Ref ref)
    : super(
        ref,
        initialState: SchedulingOperations4KScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/staff/scheduling-operations4-k',
      );
}

final scheduling_operations4_kControllerProvider =
    StateNotifierProvider<
      SchedulingOperations4KScreenController,
      SchedulingOperations4KScreenState
    >((ref) {
      return SchedulingOperations4KScreenController(ref);
    });
