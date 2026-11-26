import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhysiotherapistAppointmentsScreenState
    extends DashboardState<PhysiotherapistAppointmentsScreenState> {
  PhysiotherapistAppointmentsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PhysiotherapistAppointmentsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PhysiotherapistAppointmentsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PhysiotherapistAppointmentsScreenController
    extends BaseDashboardController<PhysiotherapistAppointmentsScreenState> {
  PhysiotherapistAppointmentsScreenController(Ref ref)
    : super(
        ref,
        initialState: PhysiotherapistAppointmentsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/physiotherapist/appointments',
      );
}

final physiotherapist_appointmentsControllerProvider =
    StateNotifierProvider<
      PhysiotherapistAppointmentsScreenController,
      PhysiotherapistAppointmentsScreenState
    >((ref) {
      return PhysiotherapistAppointmentsScreenController(ref);
    });
