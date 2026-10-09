import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BusinessDevelopmentDashboardScreenState
    extends DashboardState<BusinessDevelopmentDashboardScreenState> {
  BusinessDevelopmentDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  BusinessDevelopmentDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => BusinessDevelopmentDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class BusinessDevelopmentDashboardScreenController
    extends BaseDashboardController<BusinessDevelopmentDashboardScreenState> {
  BusinessDevelopmentDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: BusinessDevelopmentDashboardScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/business-development-dashboard',
      );
}

final business_development_dashboardControllerProvider =
    StateNotifierProvider<
      BusinessDevelopmentDashboardScreenController,
      BusinessDevelopmentDashboardScreenState
    >((ref) {
      return BusinessDevelopmentDashboardScreenController(ref);
    });
