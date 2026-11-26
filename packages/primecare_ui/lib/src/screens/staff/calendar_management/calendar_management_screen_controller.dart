import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalendarManagementScreenState
    extends DashboardState<CalendarManagementScreenState> {
  CalendarManagementScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CalendarManagementScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CalendarManagementScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CalendarManagementScreenController
    extends BaseDashboardController<CalendarManagementScreenState> {
  CalendarManagementScreenController(Ref ref)
    : super(
        ref,
        initialState: CalendarManagementScreenState(isLoading: true, data: {}),
        endpoint: '/staff/calendar-management',
      );
}

final calendar_managementControllerProvider =
    StateNotifierProvider<
      CalendarManagementScreenController,
      CalendarManagementScreenState
    >((ref) {
      return CalendarManagementScreenController(ref);
    });
