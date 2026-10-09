import 'package:primecare_models/primecare_models.dart';

class TrainingDirectorWorkflowModel extends BaseScreenState<TrainingDirectorWorkflowModel> {
  const TrainingDirectorWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingDirectorWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingDirectorWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
