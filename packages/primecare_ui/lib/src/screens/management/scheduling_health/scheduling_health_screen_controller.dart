import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulingHealthScreenState
    extends DashboardState<SchedulingHealthScreenState> {
  SchedulingHealthScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  SchedulingHealthScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => SchedulingHealthScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class SchedulingHealthScreenController
    extends BaseDashboardController<SchedulingHealthScreenState> {
  SchedulingHealthScreenController(Ref ref)
    : super(
        ref,
        initialState: SchedulingHealthScreenState(isLoading: true, data: {}),
        endpoint: '/management/scheduling-health',
      );
}

final scheduling_healthControllerProvider =
    StateNotifierProvider<
      SchedulingHealthScreenController,
      SchedulingHealthScreenState
    >((ref) {
      return SchedulingHealthScreenController(ref);
    });
