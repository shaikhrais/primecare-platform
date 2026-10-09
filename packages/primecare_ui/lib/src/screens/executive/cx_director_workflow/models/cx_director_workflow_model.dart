import 'package:primecare_models/primecare_models.dart';

class CxDirectorWorkflowModel extends BaseScreenState<CxDirectorWorkflowModel> {
  const CxDirectorWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CxDirectorWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CxDirectorWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
