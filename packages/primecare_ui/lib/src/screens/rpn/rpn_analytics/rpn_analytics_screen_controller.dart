import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RpnAnalyticsScreenState extends DashboardState<RpnAnalyticsScreenState> {
  RpnAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RpnAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RpnAnalyticsScreenState(isLoading: isLoading, error: error, data: data);
}

class RpnAnalyticsScreenController
    extends BaseDashboardController<RpnAnalyticsScreenState> {
  RpnAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: RpnAnalyticsScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rpn/rpn-analytics',
      );
}

final rpn_analyticsControllerProvider =
    StateNotifierProvider<
      RpnAnalyticsScreenController,
      RpnAnalyticsScreenState
    >((ref) {
      return RpnAnalyticsScreenController(ref);
    });
