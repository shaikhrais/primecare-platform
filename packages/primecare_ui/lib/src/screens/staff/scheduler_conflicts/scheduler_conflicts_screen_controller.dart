import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulerConflictsScreenState
    extends DashboardState<SchedulerConflictsScreenState> {
  SchedulerConflictsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  SchedulerConflictsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => SchedulerConflictsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class SchedulerConflictsScreenController
    extends BaseDashboardController<SchedulerConflictsScreenState> {
  SchedulerConflictsScreenController(Ref ref)
    : super(
        ref,
        initialState: SchedulerConflictsScreenState(isLoading: true, data: {}),
        endpoint: '/staff/scheduler-conflicts',
      );
}

final scheduler_conflictsControllerProvider =
    StateNotifierProvider<
      SchedulerConflictsScreenController,
      SchedulerConflictsScreenState
    >((ref) {
      return SchedulerConflictsScreenController(ref);
    });
