import 'package:primecare_models/primecare_models.dart';

class TrainingDirectorStaffTrainingMatrixModel extends BaseScreenState<TrainingDirectorStaffTrainingMatrixModel> {
  const TrainingDirectorStaffTrainingMatrixModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingDirectorStaffTrainingMatrixModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingDirectorStaffTrainingMatrixModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
