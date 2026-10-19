import 'package:primecare_models/primecare_models.dart';

class SchedulerProviderAvailabilityModel extends BaseScreenState<SchedulerProviderAvailabilityModel> {
  const SchedulerProviderAvailabilityModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SchedulerProviderAvailabilityModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SchedulerProviderAvailabilityModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
