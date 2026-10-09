import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CtoAnalyticsScreenState extends DashboardState<CtoAnalyticsScreenState> {
  CtoAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CtoAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CtoAnalyticsScreenState(isLoading: isLoading, error: error, data: data);
}

class CtoAnalyticsScreenController
    extends BaseDashboardController<CtoAnalyticsScreenState> {
  CtoAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: CtoAnalyticsScreenState(isLoading: true, data: {}),
        endpoint: '/executive/cto-analytics',
      );
}

final cto_analyticsControllerProvider =
    StateNotifierProvider<
      CtoAnalyticsScreenController,
      CtoAnalyticsScreenState
    >((ref) {
      return CtoAnalyticsScreenController(ref);
    });
