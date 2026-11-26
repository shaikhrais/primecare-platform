import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegionalBdmAnalyticsScreenState
    extends DashboardState<RegionalBdmAnalyticsScreenState> {
  RegionalBdmAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RegionalBdmAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RegionalBdmAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class RegionalBdmAnalyticsScreenController
    extends BaseDashboardController<RegionalBdmAnalyticsScreenState> {
  RegionalBdmAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: RegionalBdmAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/regional-bdm-analytics',
      );
}

final regional_bdm_analyticsControllerProvider =
    StateNotifierProvider<
      RegionalBdmAnalyticsScreenController,
      RegionalBdmAnalyticsScreenState
    >((ref) {
      return RegionalBdmAnalyticsScreenController(ref);
    });
