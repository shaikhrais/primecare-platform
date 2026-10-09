import 'package:primecare_models/primecare_models.dart';

class ClinicalWorkflowModel extends BaseScreenState<ClinicalWorkflowModel> {
  const ClinicalWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ClinicalWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ClinicalWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
