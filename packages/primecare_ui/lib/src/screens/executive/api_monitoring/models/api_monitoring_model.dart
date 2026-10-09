import 'package:primecare_models/primecare_models.dart';

class ApiMonitoringModel extends BaseScreenState<ApiMonitoringModel> {
  const ApiMonitoringModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ApiMonitoringModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ApiMonitoringModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
