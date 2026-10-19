import 'package:primecare_models/primecare_models.dart';

class PortalDashboardModel extends BaseScreenState<PortalDashboardModel> {
  const PortalDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PortalDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PortalDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
