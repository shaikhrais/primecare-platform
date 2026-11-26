import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswCommandCenterScreenState
    extends DashboardState<PswCommandCenterScreenState> {
  PswCommandCenterScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PswCommandCenterScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PswCommandCenterScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PswCommandCenterScreenController
    extends BaseDashboardController<PswCommandCenterScreenState> {
  PswCommandCenterScreenController(Ref ref)
    : super(
        ref,
        initialState: PswCommandCenterScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/psw/system-logs',
      );
}

final psw_command_centerControllerProvider =
    StateNotifierProvider<
      PswCommandCenterScreenController,
      PswCommandCenterScreenState
    >((ref) {
      return PswCommandCenterScreenController(ref);
    });
