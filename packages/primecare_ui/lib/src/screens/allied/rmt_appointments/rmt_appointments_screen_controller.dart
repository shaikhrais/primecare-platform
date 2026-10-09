import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RmtAppointmentsScreenState
    extends DashboardState<RmtAppointmentsScreenState> {
  RmtAppointmentsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RmtAppointmentsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RmtAppointmentsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class RmtAppointmentsScreenController
    extends BaseDashboardController<RmtAppointmentsScreenState> {
  RmtAppointmentsScreenController(Ref ref)
    : super(
        ref,
        initialState: RmtAppointmentsScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rmt/appointments',
      );
}

final rmt_appointmentsControllerProvider =
    StateNotifierProvider<
      RmtAppointmentsScreenController,
      RmtAppointmentsScreenState
    >((ref) {
      return RmtAppointmentsScreenController(ref);
    });
