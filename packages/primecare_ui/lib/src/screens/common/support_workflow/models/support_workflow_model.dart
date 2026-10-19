import 'package:primecare_models/primecare_models.dart';

class SupportWorkflowModel extends BaseScreenState<SupportWorkflowModel> {
  const SupportWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SupportWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SupportWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
