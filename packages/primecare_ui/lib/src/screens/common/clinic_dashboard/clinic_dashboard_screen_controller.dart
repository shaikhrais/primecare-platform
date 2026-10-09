import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicDashboardScreenState
    extends DashboardState<ClinicDashboardScreenState> {
  ClinicDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ClinicDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ClinicDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ClinicDashboardScreenController
    extends BaseDashboardController<ClinicDashboardScreenState> {
  ClinicDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: ClinicDashboardScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/clinical_director/clinic-dashboard',
      );
}

final clinic_dashboardControllerProvider =
    StateNotifierProvider<
      ClinicDashboardScreenController,
      ClinicDashboardScreenState
    >((ref) {
      return ClinicDashboardScreenController(ref);
    });
