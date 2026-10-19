import 'package:primecare_models/primecare_models.dart';

class CisoWorkflowModel extends BaseScreenState<CisoWorkflowModel> {
  const CisoWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CisoWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CisoWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
