import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_core/src/network/api_client.dart';
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

const _screenHealthEndpoint = '/admin/screen-health';

class AdminScreenHealthScreenController
    extends BaseDashboardController<AdminScreenHealthScreenState> {
  AdminScreenHealthScreenController(Ref ref)
    : super(
        ref,
        initialState: AdminScreenHealthScreenState(isLoading: true, data: {}),
        endpoint: '/admin/screen-health',
        loader: () async {
          final response = await ref.read(apiClientProvider).get(_screenHealthEndpoint);
          final data = response.data;
          // The shared client can synthesize a 200 offline fallback. It is not
          // evidence of screen health and must use the existing failure state.
          if (response.isSuccess && data is Map && data['status'] == 'offline_fallback') {
            return const DashboardLoadResult(isSuccess: false);
          }
          return DashboardLoadResult(
            isSuccess: response.isSuccess,
            data: data,
            error: response.error,
          );
        },
      );
}

final admin_screen_healthControllerProvider =
    StateNotifierProvider<
      AdminScreenHealthScreenController,
      AdminScreenHealthScreenState
    >((ref) {
      return AdminScreenHealthScreenController(ref);
    });
