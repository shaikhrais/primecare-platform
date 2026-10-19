import 'package:primecare_models/primecare_models.dart';

class ComplianceManagerComplianceCasesModel extends BaseScreenState<ComplianceManagerComplianceCasesModel> {
  const ComplianceManagerComplianceCasesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ComplianceManagerComplianceCasesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ComplianceManagerComplianceCasesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
