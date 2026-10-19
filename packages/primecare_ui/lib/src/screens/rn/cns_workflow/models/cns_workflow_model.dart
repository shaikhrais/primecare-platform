import 'package:primecare_models/primecare_models.dart';

class CnsWorkflowModel extends BaseScreenState<CnsWorkflowModel> {
  const CnsWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CnsWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CnsWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
