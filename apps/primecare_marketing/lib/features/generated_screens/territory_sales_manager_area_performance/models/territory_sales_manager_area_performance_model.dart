import 'package:primecare_models/primecare_models.dart';

class TerritorySalesManagerAreaPerformanceModel extends BaseScreenState<TerritorySalesManagerAreaPerformanceModel> {
  const TerritorySalesManagerAreaPerformanceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TerritorySalesManagerAreaPerformanceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TerritorySalesManagerAreaPerformanceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
