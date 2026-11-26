import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppointmentOverviewScreenState
    extends DashboardState<AppointmentOverviewScreenState> {
  AppointmentOverviewScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  AppointmentOverviewScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => AppointmentOverviewScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class AppointmentOverviewScreenController
    extends BaseDashboardController<AppointmentOverviewScreenState> {
  AppointmentOverviewScreenController(Ref ref)
    : super(
        ref,
        initialState: AppointmentOverviewScreenState(isLoading: true, data: {}),
        endpoint: '/executive/appointment-overview',
      );
}

final appointment_overviewControllerProvider =
    StateNotifierProvider<
      AppointmentOverviewScreenController,
      AppointmentOverviewScreenState
    >((ref) {
      return AppointmentOverviewScreenController(ref);
    });
