import 'package:primecare_models/primecare_models.dart';

class ComplianceManagerRiskRegisterModel extends BaseScreenState<ComplianceManagerRiskRegisterModel> {
  const ComplianceManagerRiskRegisterModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ComplianceManagerRiskRegisterModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ComplianceManagerRiskRegisterModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
