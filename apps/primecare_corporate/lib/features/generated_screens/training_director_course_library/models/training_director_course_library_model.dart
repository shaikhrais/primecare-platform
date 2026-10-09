import 'package:primecare_models/primecare_models.dart';

class TrainingDirectorCourseLibraryModel extends BaseScreenState<TrainingDirectorCourseLibraryModel> {
  const TrainingDirectorCourseLibraryModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingDirectorCourseLibraryModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingDirectorCourseLibraryModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
