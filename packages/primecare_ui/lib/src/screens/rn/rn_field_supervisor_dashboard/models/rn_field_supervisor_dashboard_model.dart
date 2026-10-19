import 'package:primecare_models/primecare_models.dart';

class RnFieldSupervisorDashboardModel extends BaseScreenState<RnFieldSupervisorDashboardModel> {
  const RnFieldSupervisorDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RnFieldSupervisorDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RnFieldSupervisorDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
