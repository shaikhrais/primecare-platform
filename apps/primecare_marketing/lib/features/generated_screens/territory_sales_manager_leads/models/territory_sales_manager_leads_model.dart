import 'package:primecare_models/primecare_models.dart';

class TerritorySalesManagerLeadsModel extends BaseScreenState<TerritorySalesManagerLeadsModel> {
  const TerritorySalesManagerLeadsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TerritorySalesManagerLeadsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TerritorySalesManagerLeadsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
