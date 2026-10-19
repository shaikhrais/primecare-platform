import 'package:primecare_models/primecare_models.dart';

class TerritorySalesManagerConversionsModel extends BaseScreenState<TerritorySalesManagerConversionsModel> {
  const TerritorySalesManagerConversionsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TerritorySalesManagerConversionsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TerritorySalesManagerConversionsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
