import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RmtClientIntakeScreenState
    extends DashboardState<RmtClientIntakeScreenState> {
  RmtClientIntakeScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RmtClientIntakeScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RmtClientIntakeScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class RmtClientIntakeScreenController
    extends BaseDashboardController<RmtClientIntakeScreenState> {
  RmtClientIntakeScreenController(Ref ref)
    : super(
        ref,
        initialState: RmtClientIntakeScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rmt/client-intake',
      );
}

final rmt_client_intakeControllerProvider =
    StateNotifierProvider<
      RmtClientIntakeScreenController,
      RmtClientIntakeScreenState
    >((ref) {
      return RmtClientIntakeScreenController(ref);
    });
