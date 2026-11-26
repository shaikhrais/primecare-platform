import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnTasksScreenState extends DashboardState<RnTasksScreenState> {
  RnTasksScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RnTasksScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RnTasksScreenState(isLoading: isLoading, error: error, data: data);
}

class RnTasksScreenController
    extends BaseDashboardController<RnTasksScreenState> {
  RnTasksScreenController(Ref ref)
    : super(
        ref,
        initialState: RnTasksScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rn/rn-tasks',
      );
}

final rn_tasksControllerProvider =
    StateNotifierProvider<RnTasksScreenController, RnTasksScreenState>((ref) {
      return RnTasksScreenController(ref);
    });
