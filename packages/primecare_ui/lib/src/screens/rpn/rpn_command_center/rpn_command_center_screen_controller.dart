import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RpnCommandCenterScreenState
    extends DashboardState<RpnCommandCenterScreenState> {
  RpnCommandCenterScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RpnCommandCenterScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RpnCommandCenterScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class RpnCommandCenterScreenController
    extends BaseDashboardController<RpnCommandCenterScreenState> {
  RpnCommandCenterScreenController(Ref ref)
    : super(
        ref,
        initialState: RpnCommandCenterScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rpn/rpn-command-center',
      );
}

final rpn_command_centerControllerProvider =
    StateNotifierProvider<
      RpnCommandCenterScreenController,
      RpnCommandCenterScreenState
    >((ref) {
      return RpnCommandCenterScreenController(ref);
    });
