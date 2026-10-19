import 'package:primecare_models/primecare_models.dart';

class InfrastructureWorkflowModel extends BaseScreenState<InfrastructureWorkflowModel> {
  const InfrastructureWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  InfrastructureWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => InfrastructureWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
