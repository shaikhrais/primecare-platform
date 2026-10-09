import 'package:primecare_models/primecare_models.dart';

class TrainingProgramsModel extends BaseScreenState<TrainingProgramsModel> {
  const TrainingProgramsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingProgramsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingProgramsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
