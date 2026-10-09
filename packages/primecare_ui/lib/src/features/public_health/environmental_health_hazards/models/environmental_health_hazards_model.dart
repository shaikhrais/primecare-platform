import 'package:primecare_models/primecare_models.dart';

class EnvironmentalHealthHazardsModel extends BaseScreenState<EnvironmentalHealthHazardsModel> {
  const EnvironmentalHealthHazardsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  EnvironmentalHealthHazardsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => EnvironmentalHealthHazardsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
