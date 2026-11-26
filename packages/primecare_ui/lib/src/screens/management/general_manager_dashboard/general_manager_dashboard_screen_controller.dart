import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GeneralManagerDashboardScreenState
    extends DashboardState<GeneralManagerDashboardScreenState> {
  GeneralManagerDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  GeneralManagerDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => GeneralManagerDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class GeneralManagerDashboardScreenController
    extends BaseDashboardController<GeneralManagerDashboardScreenState> {
  GeneralManagerDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: GeneralManagerDashboardScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint:
            '/offices/business_development/roles/general_manager/dashboard',
      );
}

final general_manager_dashboardControllerProvider =
    StateNotifierProvider<
      GeneralManagerDashboardScreenController,
      GeneralManagerDashboardScreenState
    >((ref) {
      return GeneralManagerDashboardScreenController(ref);
    });
