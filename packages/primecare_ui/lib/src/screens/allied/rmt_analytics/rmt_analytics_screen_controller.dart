import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RmtAnalyticsScreenState extends DashboardState<RmtAnalyticsScreenState> {
  RmtAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RmtAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RmtAnalyticsScreenState(isLoading: isLoading, error: error, data: data);
}

class RmtAnalyticsScreenController
    extends BaseDashboardController<RmtAnalyticsScreenState> {
  RmtAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: RmtAnalyticsScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rmt/analytics',
      );
}

final rmt_analyticsControllerProvider =
    StateNotifierProvider<
      RmtAnalyticsScreenController,
      RmtAnalyticsScreenState
    >((ref) {
      return RmtAnalyticsScreenController(ref);
    });
