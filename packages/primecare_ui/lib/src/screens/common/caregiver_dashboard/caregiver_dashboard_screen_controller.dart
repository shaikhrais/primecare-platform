import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CaregiverDashboardScreenState
    extends DashboardState<CaregiverDashboardScreenState> {
  CaregiverDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CaregiverDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CaregiverDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CaregiverDashboardScreenController
    extends BaseDashboardController<CaregiverDashboardScreenState> {
  CaregiverDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: CaregiverDashboardScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/caregiver/dashboard',
      );
}

final caregiver_dashboardControllerProvider =
    StateNotifierProvider<
      CaregiverDashboardScreenController,
      CaregiverDashboardScreenState
    >((ref) {
      return CaregiverDashboardScreenController(ref);
    });
