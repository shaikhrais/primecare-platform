import 'package:primecare_models/primecare_models.dart';

class TerritorySalesManagerWorkflowModel extends BaseScreenState<TerritorySalesManagerWorkflowModel> {
  const TerritorySalesManagerWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TerritorySalesManagerWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TerritorySalesManagerWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
