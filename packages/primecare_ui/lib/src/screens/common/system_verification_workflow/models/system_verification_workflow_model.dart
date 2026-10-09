import 'package:primecare_models/primecare_models.dart';

class SystemVerificationWorkflowModel extends BaseScreenState<SystemVerificationWorkflowModel> {
  const SystemVerificationWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SystemVerificationWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SystemVerificationWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
