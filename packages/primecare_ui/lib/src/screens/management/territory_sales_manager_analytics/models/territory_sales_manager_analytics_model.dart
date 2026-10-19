import 'package:primecare_models/primecare_models.dart';

class TerritorySalesManagerAnalyticsModel extends BaseScreenState<TerritorySalesManagerAnalyticsModel> {
  const TerritorySalesManagerAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TerritorySalesManagerAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TerritorySalesManagerAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
