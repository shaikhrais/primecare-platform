import 'package:primecare_models/primecare_models.dart';

class WorkflowExecutionModel extends BaseScreenState<WorkflowExecutionModel> {
  const WorkflowExecutionModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  WorkflowExecutionModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => WorkflowExecutionModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
