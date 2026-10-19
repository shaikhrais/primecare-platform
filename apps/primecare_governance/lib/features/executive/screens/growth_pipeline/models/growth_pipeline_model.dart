import 'package:primecare_models/primecare_models.dart';

class GrowthPipelineModel extends BaseScreenState<GrowthPipelineModel> {
  const GrowthPipelineModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  GrowthPipelineModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => GrowthPipelineModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
