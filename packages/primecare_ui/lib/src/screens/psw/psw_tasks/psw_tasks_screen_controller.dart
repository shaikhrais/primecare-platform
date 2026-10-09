import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskListScreenState extends DashboardState<TaskListScreenState> {
  TaskListScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  TaskListScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => TaskListScreenState(isLoading: isLoading, error: error, data: data);
}

class TaskListScreenController
    extends BaseDashboardController<TaskListScreenState> {
  TaskListScreenController(Ref ref)
    : super(
        ref,
        initialState: TaskListScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/psw/visit-checklist',
      );
}

final psw_tasksControllerProvider =
    StateNotifierProvider<TaskListScreenController, TaskListScreenState>((ref) {
      return TaskListScreenController(ref);
    });
