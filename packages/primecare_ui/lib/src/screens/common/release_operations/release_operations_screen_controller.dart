import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReleaseOperationsScreenState
    extends DashboardState<ReleaseOperationsScreenState> {
  ReleaseOperationsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ReleaseOperationsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ReleaseOperationsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ReleaseOperationsScreenController
    extends BaseDashboardController<ReleaseOperationsScreenState> {
  ReleaseOperationsScreenController(Ref ref)
    : super(
        ref,
        initialState: ReleaseOperationsScreenState(isLoading: true, data: {}),
        endpoint: '/common/release-operations',
      );
}

final release_operationsControllerProvider =
    StateNotifierProvider<
      ReleaseOperationsScreenController,
      ReleaseOperationsScreenState
    >((ref) {
      return ReleaseOperationsScreenController(ref);
    });
