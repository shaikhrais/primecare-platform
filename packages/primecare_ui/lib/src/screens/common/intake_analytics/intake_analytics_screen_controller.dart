import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeAnalyticsScreenState
    extends DashboardState<IntakeAnalyticsScreenState> {
  IntakeAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  IntakeAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => IntakeAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class IntakeAnalyticsScreenController
    extends BaseDashboardController<IntakeAnalyticsScreenState> {
  IntakeAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: IntakeAnalyticsScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/intake_coordinator/analytics',
      );
}

final intake_analyticsControllerProvider =
    StateNotifierProvider<
      IntakeAnalyticsScreenController,
      IntakeAnalyticsScreenState
    >((ref) {
      return IntakeAnalyticsScreenController(ref);
    });
