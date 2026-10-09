import 'package:primecare_models/primecare_models.dart';

class TrainingHubWorkflowModel extends BaseScreenState<TrainingHubWorkflowModel> {
  const TrainingHubWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingHubWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingHubWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
