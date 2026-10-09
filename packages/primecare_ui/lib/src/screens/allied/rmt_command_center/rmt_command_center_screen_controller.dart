import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RmtCommandCenterScreenState
    extends DashboardState<RmtCommandCenterScreenState> {
  RmtCommandCenterScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RmtCommandCenterScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RmtCommandCenterScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class RmtCommandCenterScreenController
    extends BaseDashboardController<RmtCommandCenterScreenState> {
  RmtCommandCenterScreenController(Ref ref)
    : super(
        ref,
        initialState: RmtCommandCenterScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rmt/command-center',
      );
}

final rmt_command_centerControllerProvider =
    StateNotifierProvider<
      RmtCommandCenterScreenController,
      RmtCommandCenterScreenState
    >((ref) {
      return RmtCommandCenterScreenController(ref);
    });
