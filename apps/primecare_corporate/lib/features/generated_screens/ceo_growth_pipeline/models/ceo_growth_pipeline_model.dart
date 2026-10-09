import 'package:primecare_models/primecare_models.dart';

class CeoGrowthPipelineModel extends BaseScreenState<CeoGrowthPipelineModel> {
  const CeoGrowthPipelineModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CeoGrowthPipelineModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CeoGrowthPipelineModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
