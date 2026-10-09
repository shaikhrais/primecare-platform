import 'package:primecare_models/primecare_models.dart';

class ComplianceManagerComplianceModel extends BaseScreenState<ComplianceManagerComplianceModel> {
  const ComplianceManagerComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ComplianceManagerComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ComplianceManagerComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
