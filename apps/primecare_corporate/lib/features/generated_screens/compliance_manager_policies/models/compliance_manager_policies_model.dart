import 'package:primecare_models/primecare_models.dart';

class ComplianceManagerPoliciesModel extends BaseScreenState<ComplianceManagerPoliciesModel> {
  const ComplianceManagerPoliciesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ComplianceManagerPoliciesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ComplianceManagerPoliciesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
