import 'package:primecare_models/primecare_models.dart';

class ArchitecturePlanningComplianceModel extends BaseScreenState<ArchitecturePlanningComplianceModel> {
  const ArchitecturePlanningComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ArchitecturePlanningComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ArchitecturePlanningComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
