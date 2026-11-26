import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SupportAnalyticsScreenState
    extends DashboardState<SupportAnalyticsScreenState> {
  SupportAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  SupportAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => SupportAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class SupportAnalyticsScreenController
    extends BaseDashboardController<SupportAnalyticsScreenState> {
  SupportAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: SupportAnalyticsScreenState(isLoading: true, data: {}),
        endpoint: '/common/support-analytics',
      );
}

final support_analyticsControllerProvider =
    StateNotifierProvider<
      SupportAnalyticsScreenController,
      SupportAnalyticsScreenState
    >((ref) {
      return SupportAnalyticsScreenController(ref);
    });
