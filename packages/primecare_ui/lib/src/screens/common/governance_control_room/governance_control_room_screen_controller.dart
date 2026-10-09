import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GovernanceControlRoomScreenState
    extends DashboardState<GovernanceControlRoomScreenState> {
  GovernanceControlRoomScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  GovernanceControlRoomScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => GovernanceControlRoomScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class GovernanceControlRoomScreenController
    extends BaseDashboardController<GovernanceControlRoomScreenState> {
  GovernanceControlRoomScreenController(Ref ref)
    : super(
        ref,
        initialState: GovernanceControlRoomScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/governance-control-room',
      );
}

final governance_control_roomControllerProvider =
    StateNotifierProvider<
      GovernanceControlRoomScreenController,
      GovernanceControlRoomScreenState
    >((ref) {
      return GovernanceControlRoomScreenController(ref);
    });
