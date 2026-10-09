import 'package:primecare_models/primecare_models.dart';

class TerritorySalesManagerPipelineModel extends BaseScreenState<TerritorySalesManagerPipelineModel> {
  const TerritorySalesManagerPipelineModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TerritorySalesManagerPipelineModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TerritorySalesManagerPipelineModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
