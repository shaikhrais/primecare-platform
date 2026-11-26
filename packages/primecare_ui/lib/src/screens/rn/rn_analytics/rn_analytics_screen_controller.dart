import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnAnalyticsScreenState extends DashboardState<RnAnalyticsScreenState> {
  RnAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RnAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RnAnalyticsScreenState(isLoading: isLoading, error: error, data: data);
}

class RnAnalyticsScreenController
    extends BaseDashboardController<RnAnalyticsScreenState> {
  RnAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: RnAnalyticsScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rn/rn-analytics',
      );
}

final rn_analyticsControllerProvider =
    StateNotifierProvider<RnAnalyticsScreenController, RnAnalyticsScreenState>((
      ref,
    ) {
      return RnAnalyticsScreenController(ref);
    });
