import 'package:primecare_models/primecare_models.dart';

class TerritorySalesManagerReportsModel extends BaseScreenState<TerritorySalesManagerReportsModel> {
  const TerritorySalesManagerReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TerritorySalesManagerReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TerritorySalesManagerReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
