import 'package:primecare_models/primecare_models.dart';

class SchedulerAvailabilityModel extends BaseScreenState<SchedulerAvailabilityModel> {
  const SchedulerAvailabilityModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SchedulerAvailabilityModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SchedulerAvailabilityModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
