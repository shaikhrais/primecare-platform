import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExecutiveCommandCenterScreenState
    extends DashboardState<ExecutiveCommandCenterScreenState> {
  ExecutiveCommandCenterScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ExecutiveCommandCenterScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ExecutiveCommandCenterScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ExecutiveCommandCenterScreenController
    extends BaseDashboardController<ExecutiveCommandCenterScreenState> {
  ExecutiveCommandCenterScreenController(Ref ref)
    : super(
        ref,
        initialState: ExecutiveCommandCenterScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/executive/executive-command-center',
      );
}

final executive_command_centerControllerProvider =
    StateNotifierProvider<
      ExecutiveCommandCenterScreenController,
      ExecutiveCommandCenterScreenState
    >((ref) {
      return ExecutiveCommandCenterScreenController(ref);
    });
