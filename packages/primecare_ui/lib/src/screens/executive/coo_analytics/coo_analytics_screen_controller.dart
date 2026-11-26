import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CooAnalyticsScreenState extends DashboardState<CooAnalyticsScreenState> {
  CooAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CooAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CooAnalyticsScreenState(isLoading: isLoading, error: error, data: data);
}

class CooAnalyticsScreenController
    extends BaseDashboardController<CooAnalyticsScreenState> {
  CooAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: CooAnalyticsScreenState(isLoading: true, data: {}),
        endpoint: '/executive/coo-analytics',
      );
}

final coo_analyticsControllerProvider =
    StateNotifierProvider<
      CooAnalyticsScreenController,
      CooAnalyticsScreenState
    >((ref) {
      return CooAnalyticsScreenController(ref);
    });
