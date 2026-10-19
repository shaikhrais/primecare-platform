import 'package:primecare_models/primecare_models.dart';

class TrainingCoordinatorWorkflowModel extends BaseScreenState<TrainingCoordinatorWorkflowModel> {
  const TrainingCoordinatorWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingCoordinatorWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingCoordinatorWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
