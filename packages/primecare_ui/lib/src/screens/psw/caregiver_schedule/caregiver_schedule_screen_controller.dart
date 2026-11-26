import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CaregiverScheduleScreenState
    extends DashboardState<CaregiverScheduleScreenState> {
  CaregiverScheduleScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CaregiverScheduleScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CaregiverScheduleScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CaregiverScheduleScreenController
    extends BaseDashboardController<CaregiverScheduleScreenState> {
  CaregiverScheduleScreenController(Ref ref)
    : super(
        ref,
        initialState: CaregiverScheduleScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/caregiver/schedule',
      );
}

final caregiver_scheduleControllerProvider =
    StateNotifierProvider<
      CaregiverScheduleScreenController,
      CaregiverScheduleScreenState
    >((ref) {
      return CaregiverScheduleScreenController(ref);
    });
