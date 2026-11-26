import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SystemVerificationAnalyticsScreenState
    extends DashboardState<SystemVerificationAnalyticsScreenState> {
  SystemVerificationAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  SystemVerificationAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => SystemVerificationAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class SystemVerificationAnalyticsScreenController
    extends BaseDashboardController<SystemVerificationAnalyticsScreenState> {
  SystemVerificationAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: SystemVerificationAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/system-verification-analytics',
      );
}

final system_verification_analyticsControllerProvider =
    StateNotifierProvider<
      SystemVerificationAnalyticsScreenController,
      SystemVerificationAnalyticsScreenState
    >((ref) {
      return SystemVerificationAnalyticsScreenController(ref);
    });
