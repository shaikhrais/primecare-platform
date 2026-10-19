import 'package:primecare_models/primecare_models.dart';

class DeploymentCenterModel extends BaseScreenState<DeploymentCenterModel> {
  const DeploymentCenterModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  DeploymentCenterModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => DeploymentCenterModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
