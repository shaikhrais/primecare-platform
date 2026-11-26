import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeploymentCenterScreenState
    extends DashboardState<DeploymentCenterScreenState> {
  DeploymentCenterScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  DeploymentCenterScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => DeploymentCenterScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class DeploymentCenterScreenController
    extends BaseDashboardController<DeploymentCenterScreenState> {
  DeploymentCenterScreenController(Ref ref)
    : super(
        ref,
        initialState: DeploymentCenterScreenState(isLoading: true, data: {}),
        endpoint: '/executive/deployment-center',
      );
}

final deployment_centerControllerProvider =
    StateNotifierProvider<
      DeploymentCenterScreenController,
      DeploymentCenterScreenState
    >((ref) {
      return DeploymentCenterScreenController(ref);
    });
