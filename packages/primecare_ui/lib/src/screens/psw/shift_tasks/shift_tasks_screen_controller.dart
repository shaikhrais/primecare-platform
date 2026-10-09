import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShiftTasksScreenState extends DashboardState<ShiftTasksScreenState> {
  ShiftTasksScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ShiftTasksScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ShiftTasksScreenState(isLoading: isLoading, error: error, data: data);
}

class ShiftTasksScreenController
    extends BaseDashboardController<ShiftTasksScreenState> {
  ShiftTasksScreenController(Ref ref)
    : super(
        ref,
        initialState: ShiftTasksScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/psw/shift-tasks',
      );
}

final shift_tasksControllerProvider =
    StateNotifierProvider<ShiftTasksScreenController, ShiftTasksScreenState>((
      ref,
    ) {
      return ShiftTasksScreenController(ref);
    });
