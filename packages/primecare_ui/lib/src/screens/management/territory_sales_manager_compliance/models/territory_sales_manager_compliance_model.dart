import 'package:primecare_models/primecare_models.dart';

class TerritorySalesManagerComplianceModel extends BaseScreenState<TerritorySalesManagerComplianceModel> {
  const TerritorySalesManagerComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TerritorySalesManagerComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TerritorySalesManagerComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
