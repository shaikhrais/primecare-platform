import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OperationsCommandCenterScreenState
    extends DashboardState<OperationsCommandCenterScreenState> {
  OperationsCommandCenterScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  OperationsCommandCenterScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => OperationsCommandCenterScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class OperationsCommandCenterScreenController
    extends BaseDashboardController<OperationsCommandCenterScreenState> {
  OperationsCommandCenterScreenController(Ref ref)
    : super(
        ref,
        initialState: OperationsCommandCenterScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/executive/operations-command-center',
      );
}

final operations_command_centerControllerProvider =
    StateNotifierProvider<
      OperationsCommandCenterScreenController,
      OperationsCommandCenterScreenState
    >((ref) {
      return OperationsCommandCenterScreenController(ref);
    });
