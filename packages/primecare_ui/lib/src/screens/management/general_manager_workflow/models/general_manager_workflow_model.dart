import 'package:primecare_models/primecare_models.dart';

class GeneralManagerWorkflowModel extends BaseScreenState<GeneralManagerWorkflowModel> {
  const GeneralManagerWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  GeneralManagerWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => GeneralManagerWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
