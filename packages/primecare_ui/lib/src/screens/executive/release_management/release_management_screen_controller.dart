import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReleaseManagementScreenState
    extends DashboardState<ReleaseManagementScreenState> {
  ReleaseManagementScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ReleaseManagementScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ReleaseManagementScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ReleaseManagementScreenController
    extends BaseDashboardController<ReleaseManagementScreenState> {
  ReleaseManagementScreenController(Ref ref)
    : super(
        ref,
        initialState: ReleaseManagementScreenState(isLoading: true, data: {}),
        endpoint: '/executive/release-management',
      );
}

final release_managementControllerProvider =
    StateNotifierProvider<
      ReleaseManagementScreenController,
      ReleaseManagementScreenState
    >((ref) {
      return ReleaseManagementScreenController(ref);
    });
