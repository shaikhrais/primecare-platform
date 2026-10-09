import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalMarketingManagerAnalyticsScreenState
    extends DashboardState<LocalMarketingManagerAnalyticsScreenState> {
  LocalMarketingManagerAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  LocalMarketingManagerAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => LocalMarketingManagerAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class LocalMarketingManagerAnalyticsScreenController
    extends BaseDashboardController<LocalMarketingManagerAnalyticsScreenState> {
  LocalMarketingManagerAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: LocalMarketingManagerAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/local-marketing-manager-analytics',
      );
}

final local_marketing_manager_analyticsControllerProvider =
    StateNotifierProvider<
      LocalMarketingManagerAnalyticsScreenController,
      LocalMarketingManagerAnalyticsScreenState
    >((ref) {
      return LocalMarketingManagerAnalyticsScreenController(ref);
    });
