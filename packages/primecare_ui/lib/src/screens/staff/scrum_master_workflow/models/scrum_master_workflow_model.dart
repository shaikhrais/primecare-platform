import 'package:primecare_models/primecare_models.dart';

class ScrumMasterWorkflowModel extends BaseScreenState<ScrumMasterWorkflowModel> {
  const ScrumMasterWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ScrumMasterWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ScrumMasterWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
