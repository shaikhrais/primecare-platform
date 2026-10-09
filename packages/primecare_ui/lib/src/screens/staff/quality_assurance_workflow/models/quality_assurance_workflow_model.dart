import 'package:primecare_models/primecare_models.dart';

class QualityAssuranceWorkflowModel extends BaseScreenState<QualityAssuranceWorkflowModel> {
  const QualityAssuranceWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  QualityAssuranceWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => QualityAssuranceWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
