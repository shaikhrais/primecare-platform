import 'package:primecare_models/primecare_models.dart';

class TerritorySalesMappingModel extends BaseScreenState<TerritorySalesMappingModel> {
  const TerritorySalesMappingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TerritorySalesMappingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TerritorySalesMappingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
