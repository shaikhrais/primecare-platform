import 'package:primecare_models/primecare_models.dart';

class ItAdministratorDashboardModel extends BaseScreenState<ItAdministratorDashboardModel> {
  const ItAdministratorDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ItAdministratorDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ItAdministratorDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
