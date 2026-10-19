import 'package:primecare_models/primecare_models.dart';

class TrainingCoordinatorCoursesModel extends BaseScreenState<TrainingCoordinatorCoursesModel> {
  const TrainingCoordinatorCoursesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingCoordinatorCoursesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingCoordinatorCoursesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
