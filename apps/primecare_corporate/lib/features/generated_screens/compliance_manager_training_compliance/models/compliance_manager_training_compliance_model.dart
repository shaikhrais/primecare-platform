import 'package:primecare_models/primecare_models.dart';

class ComplianceManagerTrainingComplianceModel extends BaseScreenState<ComplianceManagerTrainingComplianceModel> {
  const ComplianceManagerTrainingComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ComplianceManagerTrainingComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ComplianceManagerTrainingComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
