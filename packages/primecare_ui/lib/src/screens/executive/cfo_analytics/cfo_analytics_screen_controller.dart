import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CfoAnalyticsScreenState extends DashboardState<CfoAnalyticsScreenState> {
  CfoAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CfoAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CfoAnalyticsScreenState(isLoading: isLoading, error: error, data: data);
}

class CfoAnalyticsScreenController
    extends BaseDashboardController<CfoAnalyticsScreenState> {
  CfoAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: CfoAnalyticsScreenState(isLoading: true, data: {}),
        endpoint: '/executive/cfo-analytics',
      );
}

final cfo_analyticsControllerProvider =
    StateNotifierProvider<
      CfoAnalyticsScreenController,
      CfoAnalyticsScreenState
    >((ref) {
      return CfoAnalyticsScreenController(ref);
    });
