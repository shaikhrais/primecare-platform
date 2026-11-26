import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChiropractorAppointmentsScreenState
    extends DashboardState<ChiropractorAppointmentsScreenState> {
  ChiropractorAppointmentsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ChiropractorAppointmentsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ChiropractorAppointmentsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ChiropractorAppointmentsScreenController
    extends BaseDashboardController<ChiropractorAppointmentsScreenState> {
  ChiropractorAppointmentsScreenController(Ref ref)
    : super(
        ref,
        initialState: ChiropractorAppointmentsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/chiropractor/appointments',
      );
}

final chiropractor_appointmentsControllerProvider =
    StateNotifierProvider<
      ChiropractorAppointmentsScreenController,
      ChiropractorAppointmentsScreenState
    >((ref) {
      return ChiropractorAppointmentsScreenController(ref);
    });
