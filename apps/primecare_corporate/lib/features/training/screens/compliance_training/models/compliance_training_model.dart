import 'package:primecare_models/primecare_models.dart';

class ComplianceTrainingModel extends BaseScreenState<ComplianceTrainingModel> {
  const ComplianceTrainingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ComplianceTrainingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ComplianceTrainingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
