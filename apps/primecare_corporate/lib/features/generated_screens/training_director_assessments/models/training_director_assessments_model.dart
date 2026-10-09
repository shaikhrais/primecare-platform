import 'package:primecare_models/primecare_models.dart';

class TrainingDirectorAssessmentsModel extends BaseScreenState<TrainingDirectorAssessmentsModel> {
  const TrainingDirectorAssessmentsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingDirectorAssessmentsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingDirectorAssessmentsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
