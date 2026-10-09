import 'package:primecare_models/primecare_models.dart';

class DynamicWorkflowModel extends BaseScreenState<DynamicWorkflowModel> {
  const DynamicWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  DynamicWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => DynamicWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
