import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppointmentScreenState extends DashboardState<AppointmentScreenState> {
  AppointmentScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  AppointmentScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => AppointmentScreenState(isLoading: isLoading, error: error, data: data);
}

class AppointmentScreenController
    extends BaseDashboardController<AppointmentScreenState> {
  AppointmentScreenController(Ref ref)
    : super(
        ref,
        initialState: AppointmentScreenState(isLoading: true, data: {}),
        endpoint: '/common/appointment',
      );
}

final appointmentControllerProvider =
    StateNotifierProvider<AppointmentScreenController, AppointmentScreenState>((
      ref,
    ) {
      return AppointmentScreenController(ref);
    });
