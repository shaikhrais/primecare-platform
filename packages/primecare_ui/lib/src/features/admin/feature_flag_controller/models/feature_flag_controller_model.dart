import 'package:primecare_models/primecare_models.dart';

class FeatureFlagControllerModel extends BaseScreenState<FeatureFlagControllerModel> {
  const FeatureFlagControllerModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FeatureFlagControllerModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FeatureFlagControllerModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
