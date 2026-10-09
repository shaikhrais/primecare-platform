import 'package:primecare_models/primecare_models.dart';

class SchedulerOpenShiftsModel extends BaseScreenState<SchedulerOpenShiftsModel> {
  const SchedulerOpenShiftsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SchedulerOpenShiftsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SchedulerOpenShiftsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
