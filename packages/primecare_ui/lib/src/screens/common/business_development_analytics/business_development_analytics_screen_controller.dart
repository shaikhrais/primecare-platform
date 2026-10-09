import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BusinessDevelopmentAnalyticsScreenState
    extends DashboardState<BusinessDevelopmentAnalyticsScreenState> {
  BusinessDevelopmentAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  BusinessDevelopmentAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => BusinessDevelopmentAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class BusinessDevelopmentAnalyticsScreenController
    extends BaseDashboardController<BusinessDevelopmentAnalyticsScreenState> {
  BusinessDevelopmentAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: BusinessDevelopmentAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/business-development-analytics',
      );
}

final business_development_analyticsControllerProvider =
    StateNotifierProvider<
      BusinessDevelopmentAnalyticsScreenController,
      BusinessDevelopmentAnalyticsScreenState
    >((ref) {
      return BusinessDevelopmentAnalyticsScreenController(ref);
    });
