import 'package:primecare_models/primecare_models.dart';

class PediatricWorkflowModel extends BaseScreenState<PediatricWorkflowModel> {
  const PediatricWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PediatricWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PediatricWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
