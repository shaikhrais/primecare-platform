import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisteredNurseRnFieldSupervisorAnalyticsScreenState
    extends
        DashboardState<RegisteredNurseRnFieldSupervisorAnalyticsScreenState> {
  RegisteredNurseRnFieldSupervisorAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RegisteredNurseRnFieldSupervisorAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RegisteredNurseRnFieldSupervisorAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class RegisteredNurseRnFieldSupervisorAnalyticsScreenController
    extends
        BaseDashboardController<
          RegisteredNurseRnFieldSupervisorAnalyticsScreenState
        > {
  RegisteredNurseRnFieldSupervisorAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: RegisteredNurseRnFieldSupervisorAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/rn/rn-field-supervisor-analytics',
      );
}

final rn_field_supervisor_analyticsControllerProvider =
    StateNotifierProvider<
      RegisteredNurseRnFieldSupervisorAnalyticsScreenController,
      RegisteredNurseRnFieldSupervisorAnalyticsScreenState
    >((ref) {
      return RegisteredNurseRnFieldSupervisorAnalyticsScreenController(ref);
    });
