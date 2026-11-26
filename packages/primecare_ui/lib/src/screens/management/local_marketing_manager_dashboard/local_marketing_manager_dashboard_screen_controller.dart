import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalMarketingManagerDashboardScreenState
    extends DashboardState<LocalMarketingManagerDashboardScreenState> {
  LocalMarketingManagerDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  LocalMarketingManagerDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => LocalMarketingManagerDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class LocalMarketingManagerDashboardScreenController
    extends BaseDashboardController<LocalMarketingManagerDashboardScreenState> {
  LocalMarketingManagerDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: LocalMarketingManagerDashboardScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/marketing/roles/local_marketing_manager/dashboard',
      );
}

final local_marketing_manager_dashboardControllerProvider =
    StateNotifierProvider<
      LocalMarketingManagerDashboardScreenController,
      LocalMarketingManagerDashboardScreenState
    >((ref) {
      return LocalMarketingManagerDashboardScreenController(ref);
    });
