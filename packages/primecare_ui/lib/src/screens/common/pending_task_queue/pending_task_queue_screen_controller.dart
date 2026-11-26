import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PendingTaskQueueScreenState
    extends DashboardState<PendingTaskQueueScreenState> {
  PendingTaskQueueScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PendingTaskQueueScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PendingTaskQueueScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PendingTaskQueueScreenController
    extends BaseDashboardController<PendingTaskQueueScreenState> {
  PendingTaskQueueScreenController(Ref ref)
    : super(
        ref,
        initialState: PendingTaskQueueScreenState(isLoading: true, data: {}),
        endpoint: '/common/pending-task-queue',
      );
}

final pending_task_queueControllerProvider =
    StateNotifierProvider<
      PendingTaskQueueScreenController,
      PendingTaskQueueScreenState
    >((ref) {
      return PendingTaskQueueScreenController(ref);
    });
