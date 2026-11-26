import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientDashboardScreenState
    extends DashboardState<PatientDashboardScreenState> {
  PatientDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PatientDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PatientDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PatientDashboardScreenController
    extends BaseDashboardController<PatientDashboardScreenState> {
  PatientDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: PatientDashboardScreenState(isLoading: true, data: {}),
        endpoint: '/offices/client/roles/client/dashboard',
      );
}

final patient_dashboardControllerProvider =
    StateNotifierProvider<
      PatientDashboardScreenController,
      PatientDashboardScreenState
    >((ref) {
      return PatientDashboardScreenController(ref);
    });
