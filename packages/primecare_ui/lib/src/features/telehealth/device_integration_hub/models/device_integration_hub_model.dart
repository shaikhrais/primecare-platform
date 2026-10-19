import 'package:primecare_models/primecare_models.dart';

class DeviceIntegrationHubModel extends BaseScreenState<DeviceIntegrationHubModel> {
  const DeviceIntegrationHubModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  DeviceIntegrationHubModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => DeviceIntegrationHubModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
