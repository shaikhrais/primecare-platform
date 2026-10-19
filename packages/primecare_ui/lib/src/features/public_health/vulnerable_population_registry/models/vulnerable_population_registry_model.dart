import 'package:primecare_models/primecare_models.dart';

class VulnerablePopulationRegistryModel extends BaseScreenState<VulnerablePopulationRegistryModel> {
  const VulnerablePopulationRegistryModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  VulnerablePopulationRegistryModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => VulnerablePopulationRegistryModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
