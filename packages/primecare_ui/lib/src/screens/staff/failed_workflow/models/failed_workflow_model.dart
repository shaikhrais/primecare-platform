import 'package:primecare_models/primecare_models.dart';

class FailedWorkflowModel extends BaseScreenState<FailedWorkflowModel> {
  const FailedWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FailedWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FailedWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
