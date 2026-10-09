import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HeadOfMarketingAnalyticsScreenState
    extends DashboardState<HeadOfMarketingAnalyticsScreenState> {
  HeadOfMarketingAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HeadOfMarketingAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => HeadOfMarketingAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class HeadOfMarketingAnalyticsScreenController
    extends BaseDashboardController<HeadOfMarketingAnalyticsScreenState> {
  HeadOfMarketingAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: HeadOfMarketingAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/head-of-marketing-analytics',
      );
}

final head_of_marketing_analyticsControllerProvider =
    StateNotifierProvider<
      HeadOfMarketingAnalyticsScreenController,
      HeadOfMarketingAnalyticsScreenState
    >((ref) {
      return HeadOfMarketingAnalyticsScreenController(ref);
    });
