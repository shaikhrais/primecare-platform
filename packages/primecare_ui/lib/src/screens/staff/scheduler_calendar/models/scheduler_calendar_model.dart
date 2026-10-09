import 'package:primecare_models/primecare_models.dart';

class SchedulerCalendarModel extends BaseScreenState<SchedulerCalendarModel> {
  const SchedulerCalendarModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SchedulerCalendarModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SchedulerCalendarModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
