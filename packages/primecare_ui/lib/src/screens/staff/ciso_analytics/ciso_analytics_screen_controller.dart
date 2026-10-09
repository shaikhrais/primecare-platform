import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CisoAnalyticsScreenState
    extends DashboardState<CisoAnalyticsScreenState> {
  CisoAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CisoAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      CisoAnalyticsScreenState(isLoading: isLoading, error: error, data: data);
}

class CisoAnalyticsScreenController
    extends BaseDashboardController<CisoAnalyticsScreenState> {
  CisoAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: CisoAnalyticsScreenState(isLoading: true, data: {}),
        endpoint: '/executive/ciso-analytics',
      );
}

final ciso_analyticsControllerProvider =
    StateNotifierProvider<
      CisoAnalyticsScreenController,
      CisoAnalyticsScreenState
    >((ref) {
      return CisoAnalyticsScreenController(ref);
    });
