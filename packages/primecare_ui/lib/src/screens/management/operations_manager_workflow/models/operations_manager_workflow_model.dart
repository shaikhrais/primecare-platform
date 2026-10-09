import 'package:primecare_models/primecare_models.dart';

class OperationsManagerWorkflowModel extends BaseScreenState<OperationsManagerWorkflowModel> {
  const OperationsManagerWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  OperationsManagerWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => OperationsManagerWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
