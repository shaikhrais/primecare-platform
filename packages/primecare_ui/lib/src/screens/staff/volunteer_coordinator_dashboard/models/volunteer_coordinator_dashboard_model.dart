import 'package:primecare_models/primecare_models.dart';

class VolunteerCoordinatorDashboardModel extends BaseScreenState<VolunteerCoordinatorDashboardModel> {
  const VolunteerCoordinatorDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  VolunteerCoordinatorDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => VolunteerCoordinatorDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
