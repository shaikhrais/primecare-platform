import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhysicianAnalyticsScreenState
    extends DashboardState<PhysicianAnalyticsScreenState> {
  PhysicianAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PhysicianAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PhysicianAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PhysicianAnalyticsScreenController
    extends BaseDashboardController<PhysicianAnalyticsScreenState> {
  PhysicianAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: PhysicianAnalyticsScreenState(isLoading: true, data: {}),
        endpoint: '/clinical/physician-analytics',
      );
}

final physician_analyticsControllerProvider =
    StateNotifierProvider<
      PhysicianAnalyticsScreenController,
      PhysicianAnalyticsScreenState
    >((ref) {
      return PhysicianAnalyticsScreenController(ref);
    });
