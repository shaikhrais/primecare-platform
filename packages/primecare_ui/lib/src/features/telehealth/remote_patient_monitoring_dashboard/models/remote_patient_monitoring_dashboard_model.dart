import 'package:primecare_models/primecare_models.dart';

class RemotePatientMonitoringDashboardModel extends BaseScreenState<RemotePatientMonitoringDashboardModel> {
  const RemotePatientMonitoringDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RemotePatientMonitoringDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RemotePatientMonitoringDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
