import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegionalManagerUsaAnalyticsScreenState
    extends DashboardState<RegionalManagerUsaAnalyticsScreenState> {
  RegionalManagerUsaAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RegionalManagerUsaAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RegionalManagerUsaAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class RegionalManagerUsaAnalyticsScreenController
    extends BaseDashboardController<RegionalManagerUsaAnalyticsScreenState> {
  RegionalManagerUsaAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: RegionalManagerUsaAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/regional-manager-usa-analytics',
      );
}

final regional_manager_usa_analyticsControllerProvider =
    StateNotifierProvider<
      RegionalManagerUsaAnalyticsScreenController,
      RegionalManagerUsaAnalyticsScreenState
    >((ref) {
      return RegionalManagerUsaAnalyticsScreenController(ref);
    });
