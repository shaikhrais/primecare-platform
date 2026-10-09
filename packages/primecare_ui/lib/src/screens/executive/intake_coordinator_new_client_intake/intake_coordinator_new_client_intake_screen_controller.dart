import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeCoordinatorNewClientIntakeScreenState
    extends DashboardState<IntakeCoordinatorNewClientIntakeScreenState> {
  IntakeCoordinatorNewClientIntakeScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  IntakeCoordinatorNewClientIntakeScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => IntakeCoordinatorNewClientIntakeScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class IntakeCoordinatorNewClientIntakeScreenController
    extends
        BaseDashboardController<IntakeCoordinatorNewClientIntakeScreenState> {
  IntakeCoordinatorNewClientIntakeScreenController(Ref ref)
    : super(
        ref,
        initialState: IntakeCoordinatorNewClientIntakeScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/executive/intake-coordinator-new-client-intake',
      );
}

final intake_coordinator_new_client_intakeControllerProvider =
    StateNotifierProvider<
      IntakeCoordinatorNewClientIntakeScreenController,
      IntakeCoordinatorNewClientIntakeScreenState
    >((ref) {
      return IntakeCoordinatorNewClientIntakeScreenController(ref);
    });
