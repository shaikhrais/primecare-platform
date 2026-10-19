import 'package:primecare_models/primecare_models.dart';

class TerritorySalesManagerCompetitorsModel extends BaseScreenState<TerritorySalesManagerCompetitorsModel> {
  const TerritorySalesManagerCompetitorsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TerritorySalesManagerCompetitorsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TerritorySalesManagerCompetitorsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
