import 'package:primecare_models/primecare_models.dart';

class TrainingCoordinatorTrainingScheduleModel extends BaseScreenState<TrainingCoordinatorTrainingScheduleModel> {
  const TrainingCoordinatorTrainingScheduleModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingCoordinatorTrainingScheduleModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingCoordinatorTrainingScheduleModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
