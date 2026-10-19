import 'package:primecare_models/primecare_models.dart';

class VolunteerCoordinatorAnalyticsModel extends BaseScreenState<VolunteerCoordinatorAnalyticsModel> {
  const VolunteerCoordinatorAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  VolunteerCoordinatorAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => VolunteerCoordinatorAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
