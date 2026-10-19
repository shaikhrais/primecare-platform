import 'package:primecare_models/primecare_models.dart';

class ComplianceManagerWorkflowModel extends BaseScreenState<ComplianceManagerWorkflowModel> {
  const ComplianceManagerWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ComplianceManagerWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ComplianceManagerWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
