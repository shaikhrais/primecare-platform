import 'package:primecare_models/primecare_models.dart';

class TrainingDirectorTrainerAssignmentsModel extends BaseScreenState<TrainingDirectorTrainerAssignmentsModel> {
  const TrainingDirectorTrainerAssignmentsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingDirectorTrainerAssignmentsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingDirectorTrainerAssignmentsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
