import 'package:primecare_models/primecare_models.dart';

class LegalWorkflowModel extends BaseScreenState<LegalWorkflowModel> {
  const LegalWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  LegalWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => LegalWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
