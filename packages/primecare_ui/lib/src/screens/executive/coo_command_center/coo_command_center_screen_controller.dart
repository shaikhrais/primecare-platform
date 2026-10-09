import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CooCommandCenterScreenState
    extends DashboardState<CooCommandCenterScreenState> {
  CooCommandCenterScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CooCommandCenterScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CooCommandCenterScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CooCommandCenterScreenController
    extends BaseDashboardController<CooCommandCenterScreenState> {
  CooCommandCenterScreenController(Ref ref)
    : super(
        ref,
        initialState: CooCommandCenterScreenState(isLoading: true, data: {}),
        endpoint: '/executive/coo-command-center',
      );
}

final coo_command_centerControllerProvider =
    StateNotifierProvider<
      CooCommandCenterScreenController,
      CooCommandCenterScreenState
    >((ref) {
      return CooCommandCenterScreenController(ref);
    });
