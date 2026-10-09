import 'package:primecare_models/primecare_models.dart';

class SchedulerCoordinatorReportsModel extends BaseScreenState<SchedulerCoordinatorReportsModel> {
  const SchedulerCoordinatorReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SchedulerCoordinatorReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SchedulerCoordinatorReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
