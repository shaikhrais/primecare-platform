import 'package:primecare_models/primecare_models.dart';

class EmployeeAnalyticsModel extends BaseScreenState<EmployeeAnalyticsModel> {
  const EmployeeAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  EmployeeAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => EmployeeAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
