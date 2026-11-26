import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PediatricSpecialistAnalyticsScreenState
    extends DashboardState<PediatricSpecialistAnalyticsScreenState> {
  PediatricSpecialistAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PediatricSpecialistAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PediatricSpecialistAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PediatricSpecialistAnalyticsScreenController
    extends BaseDashboardController<PediatricSpecialistAnalyticsScreenState> {
  PediatricSpecialistAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: PediatricSpecialistAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/clinical/pediatric-analytics',
      );
}

final pediatric_analyticsControllerProvider =
    StateNotifierProvider<
      PediatricSpecialistAnalyticsScreenController,
      PediatricSpecialistAnalyticsScreenState
    >((ref) {
      return PediatricSpecialistAnalyticsScreenController(ref);
    });
