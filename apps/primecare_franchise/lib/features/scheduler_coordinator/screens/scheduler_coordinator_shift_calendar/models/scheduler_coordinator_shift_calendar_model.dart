import 'package:primecare_models/primecare_models.dart';

class SchedulerCoordinatorShiftCalendarModel extends BaseScreenState<SchedulerCoordinatorShiftCalendarModel> {
  const SchedulerCoordinatorShiftCalendarModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SchedulerCoordinatorShiftCalendarModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SchedulerCoordinatorShiftCalendarModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
