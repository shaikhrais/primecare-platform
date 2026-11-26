import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SystemHealthScreenState extends DashboardState<SystemHealthScreenState> {
  SystemHealthScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  SystemHealthScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => SystemHealthScreenState(isLoading: isLoading, error: error, data: data);
}

class SystemHealthScreenController
    extends BaseDashboardController<SystemHealthScreenState> {
  SystemHealthScreenController(Ref ref)
    : super(
        ref,
        initialState: SystemHealthScreenState(isLoading: true, data: {}),
        endpoint: '/executive/system-health',
      );
}

final system_healthControllerProvider =
    StateNotifierProvider<
      SystemHealthScreenController,
      SystemHealthScreenState
    >((ref) {
      return SystemHealthScreenController(ref);
    });
