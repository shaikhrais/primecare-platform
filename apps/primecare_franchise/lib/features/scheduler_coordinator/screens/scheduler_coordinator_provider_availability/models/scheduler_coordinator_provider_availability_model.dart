import 'package:primecare_models/primecare_models.dart';

class SchedulerCoordinatorProviderAvailabilityModel extends BaseScreenState<SchedulerCoordinatorProviderAvailabilityModel> {
  const SchedulerCoordinatorProviderAvailabilityModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SchedulerCoordinatorProviderAvailabilityModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SchedulerCoordinatorProviderAvailabilityModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
