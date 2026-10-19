import 'package:primecare_models/primecare_models.dart';

class CooWorkflowIssuesModel extends BaseScreenState<CooWorkflowIssuesModel> {
  const CooWorkflowIssuesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CooWorkflowIssuesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CooWorkflowIssuesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
