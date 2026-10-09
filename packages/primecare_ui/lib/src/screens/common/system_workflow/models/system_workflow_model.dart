import 'package:primecare_models/primecare_models.dart';

class SystemWorkflowModel extends BaseScreenState<SystemWorkflowModel> {
  const SystemWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SystemWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SystemWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
