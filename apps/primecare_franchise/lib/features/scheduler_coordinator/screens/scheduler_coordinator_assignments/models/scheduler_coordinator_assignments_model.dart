import 'package:primecare_models/primecare_models.dart';

class SchedulerCoordinatorAssignmentsModel extends BaseScreenState<SchedulerCoordinatorAssignmentsModel> {
  const SchedulerCoordinatorAssignmentsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SchedulerCoordinatorAssignmentsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SchedulerCoordinatorAssignmentsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
