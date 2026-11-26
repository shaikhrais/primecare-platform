import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseSalesManagerDashboardScreenState
    extends DashboardState<FranchiseSalesManagerDashboardScreenState> {
  FranchiseSalesManagerDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FranchiseSalesManagerDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => FranchiseSalesManagerDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class FranchiseSalesManagerDashboardScreenController
    extends BaseDashboardController<FranchiseSalesManagerDashboardScreenState> {
  FranchiseSalesManagerDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: FranchiseSalesManagerDashboardScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint:
            '/offices/business_development/roles/franchise_sales_manager/dashboard',
      );
}

final franchise_sales_manager_dashboardControllerProvider =
    StateNotifierProvider<
      FranchiseSalesManagerDashboardScreenController,
      FranchiseSalesManagerDashboardScreenState
    >((ref) {
      return FranchiseSalesManagerDashboardScreenController(ref);
    });
