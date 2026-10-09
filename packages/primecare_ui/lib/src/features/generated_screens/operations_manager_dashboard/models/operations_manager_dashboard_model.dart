import 'package:primecare_models/primecare_models.dart';

class OperationsManagerDashboardModel extends BaseScreenState<OperationsManagerDashboardModel> {
  const OperationsManagerDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  OperationsManagerDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => OperationsManagerDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
