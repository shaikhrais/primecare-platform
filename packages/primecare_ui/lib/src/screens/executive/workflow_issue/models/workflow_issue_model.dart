import 'package:primecare_models/primecare_models.dart';

class WorkflowIssueModel extends BaseScreenState<WorkflowIssueModel> {
  const WorkflowIssueModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  WorkflowIssueModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => WorkflowIssueModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
