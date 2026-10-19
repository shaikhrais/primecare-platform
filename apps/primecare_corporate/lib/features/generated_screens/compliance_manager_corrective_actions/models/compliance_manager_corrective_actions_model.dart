import 'package:primecare_models/primecare_models.dart';

class ComplianceManagerCorrectiveActionsModel extends BaseScreenState<ComplianceManagerCorrectiveActionsModel> {
  const ComplianceManagerCorrectiveActionsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ComplianceManagerCorrectiveActionsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ComplianceManagerCorrectiveActionsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
