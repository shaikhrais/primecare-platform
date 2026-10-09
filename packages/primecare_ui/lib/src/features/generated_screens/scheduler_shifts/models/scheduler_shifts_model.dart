import 'package:primecare_models/primecare_models.dart';

class SchedulerShiftsModel extends BaseScreenState<SchedulerShiftsModel> {
  const SchedulerShiftsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SchedulerShiftsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SchedulerShiftsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
