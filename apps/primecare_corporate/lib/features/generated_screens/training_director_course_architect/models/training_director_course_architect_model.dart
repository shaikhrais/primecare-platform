import 'package:primecare_models/primecare_models.dart';

class TrainingDirectorCourseArchitectModel extends BaseScreenState<TrainingDirectorCourseArchitectModel> {
  const TrainingDirectorCourseArchitectModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingDirectorCourseArchitectModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingDirectorCourseArchitectModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
