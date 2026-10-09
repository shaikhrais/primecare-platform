import 'package:primecare_models/primecare_models.dart';

class EmployeeDashboardModel extends BaseScreenState<EmployeeDashboardModel> {
  const EmployeeDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  EmployeeDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => EmployeeDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
