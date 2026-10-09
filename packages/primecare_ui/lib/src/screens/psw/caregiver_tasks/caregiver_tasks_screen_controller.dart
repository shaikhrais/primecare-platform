import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CaregiverTasksScreenState
    extends DashboardState<CaregiverTasksScreenState> {
  CaregiverTasksScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CaregiverTasksScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      CaregiverTasksScreenState(isLoading: isLoading, error: error, data: data);
}

class CaregiverTasksScreenController
    extends BaseDashboardController<CaregiverTasksScreenState> {
  CaregiverTasksScreenController(Ref ref)
    : super(
        ref,
        initialState: CaregiverTasksScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/caregiver/tasks',
      );
}

final caregiver_tasksControllerProvider =
    StateNotifierProvider<
      CaregiverTasksScreenController,
      CaregiverTasksScreenState
    >((ref) {
      return CaregiverTasksScreenController(ref);
    });
