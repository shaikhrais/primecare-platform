import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PartnershipManagerDashboardScreenState
    extends DashboardState<PartnershipManagerDashboardScreenState> {
  PartnershipManagerDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PartnershipManagerDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PartnershipManagerDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PartnershipManagerDashboardScreenController
    extends BaseDashboardController<PartnershipManagerDashboardScreenState> {
  PartnershipManagerDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: PartnershipManagerDashboardScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint:
            '/offices/business_development/roles/partnership_manager/dashboard',
      );
}

final partnership_manager_dashboardControllerProvider =
    StateNotifierProvider<
      PartnershipManagerDashboardScreenController,
      PartnershipManagerDashboardScreenState
    >((ref) {
      return PartnershipManagerDashboardScreenController(ref);
    });
