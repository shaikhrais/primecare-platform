import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminScreenHealthScreenState
    extends DashboardState<AdminScreenHealthScreenState> {
  AdminScreenHealthScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  AdminScreenHealthScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => AdminScreenHealthScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class AdminScreenHealthScreenController
    extends BaseDashboardController<AdminScreenHealthScreenState> {
  AdminScreenHealthScreenController(Ref ref)
    : super(
        ref,
        initialState: AdminScreenHealthScreenState(isLoading: true, data: {}),
        endpoint: '/admin/screen-health',
      );
}

final admin_screen_healthControllerProvider =
    StateNotifierProvider<
      AdminScreenHealthScreenController,
      AdminScreenHealthScreenState
    >((ref) {
      return AdminScreenHealthScreenController(ref);
    });
