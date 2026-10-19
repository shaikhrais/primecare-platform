import 'package:primecare_models/primecare_models.dart';

class SchedulerCoordinatorAppointmentCalendarModel extends BaseScreenState<SchedulerCoordinatorAppointmentCalendarModel> {
  const SchedulerCoordinatorAppointmentCalendarModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SchedulerCoordinatorAppointmentCalendarModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SchedulerCoordinatorAppointmentCalendarModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
