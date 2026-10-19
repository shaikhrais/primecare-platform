import 'package:primecare_models/primecare_models.dart';

class GovernanceOfficerComplianceModel extends BaseScreenState<GovernanceOfficerComplianceModel> {
  const GovernanceOfficerComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  GovernanceOfficerComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => GovernanceOfficerComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
