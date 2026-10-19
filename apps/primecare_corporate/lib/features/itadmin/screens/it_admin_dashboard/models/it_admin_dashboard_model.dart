import 'package:primecare_models/primecare_models.dart';

class ItAdminDashboardModel extends BaseScreenState<ItAdminDashboardModel> {
  const ItAdminDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ItAdminDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ItAdminDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
