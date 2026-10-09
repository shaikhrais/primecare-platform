import 'package:primecare_models/primecare_models.dart';

class SchedulerCoordinatorOpenShiftsModel extends BaseScreenState<SchedulerCoordinatorOpenShiftsModel> {
  const SchedulerCoordinatorOpenShiftsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SchedulerCoordinatorOpenShiftsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SchedulerCoordinatorOpenShiftsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
