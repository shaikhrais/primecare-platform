import 'package:primecare_models/primecare_models.dart';

class TrainingDirectorComplianceTrainingModel extends BaseScreenState<TrainingDirectorComplianceTrainingModel> {
  const TrainingDirectorComplianceTrainingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingDirectorComplianceTrainingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingDirectorComplianceTrainingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
