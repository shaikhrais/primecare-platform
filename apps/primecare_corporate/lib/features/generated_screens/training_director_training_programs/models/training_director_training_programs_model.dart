import 'package:primecare_models/primecare_models.dart';

class TrainingDirectorTrainingProgramsModel extends BaseScreenState<TrainingDirectorTrainingProgramsModel> {
  const TrainingDirectorTrainingProgramsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingDirectorTrainingProgramsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingDirectorTrainingProgramsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
