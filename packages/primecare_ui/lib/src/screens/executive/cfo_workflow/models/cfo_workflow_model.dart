import 'package:primecare_models/primecare_models.dart';

class CfoWorkflowModel extends BaseScreenState<CfoWorkflowModel> {
  const CfoWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CfoWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CfoWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
