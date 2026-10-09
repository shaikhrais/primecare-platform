import 'package:primecare_models/primecare_models.dart';

class VolunteerDashboardModel extends BaseScreenState<VolunteerDashboardModel> {
  const VolunteerDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  VolunteerDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => VolunteerDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
