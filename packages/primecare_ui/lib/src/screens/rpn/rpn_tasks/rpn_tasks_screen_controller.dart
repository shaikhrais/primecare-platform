import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RpnTasksScreenState extends DashboardState<RpnTasksScreenState> {
  RpnTasksScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RpnTasksScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RpnTasksScreenState(isLoading: isLoading, error: error, data: data);
}

class RpnTasksScreenController
    extends BaseDashboardController<RpnTasksScreenState> {
  RpnTasksScreenController(Ref ref)
    : super(
        ref,
        initialState: RpnTasksScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rpn/rpn-tasks',
      );
}

final rpn_tasksControllerProvider =
    StateNotifierProvider<RpnTasksScreenController, RpnTasksScreenState>((ref) {
      return RpnTasksScreenController(ref);
    });
