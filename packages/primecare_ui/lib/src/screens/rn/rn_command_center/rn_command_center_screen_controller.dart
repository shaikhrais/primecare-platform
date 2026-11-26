import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnCommandCenterScreenState
    extends DashboardState<RnCommandCenterScreenState> {
  RnCommandCenterScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RnCommandCenterScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RnCommandCenterScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class RnCommandCenterScreenController
    extends BaseDashboardController<RnCommandCenterScreenState> {
  RnCommandCenterScreenController(Ref ref)
    : super(
        ref,
        initialState: RnCommandCenterScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rn/rn-command-center',
      );
}

final rn_command_centerControllerProvider =
    StateNotifierProvider<
      RnCommandCenterScreenController,
      RnCommandCenterScreenState
    >((ref) {
      return RnCommandCenterScreenController(ref);
    });
