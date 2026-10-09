import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SystemVerificationDashboardScreenState
    extends DashboardState<SystemVerificationDashboardScreenState> {
  SystemVerificationDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  SystemVerificationDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => SystemVerificationDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class SystemVerificationDashboardScreenController
    extends BaseDashboardController<SystemVerificationDashboardScreenState> {
  SystemVerificationDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: SystemVerificationDashboardScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/system-verification-dashboard',
      );
}

final system_verification_dashboardControllerProvider =
    StateNotifierProvider<
      SystemVerificationDashboardScreenController,
      SystemVerificationDashboardScreenState
    >((ref) {
      return SystemVerificationDashboardScreenController(ref);
    });
