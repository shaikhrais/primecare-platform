import 'package:primecare_models/primecare_models.dart';

class TrainingDirectorReportsModel extends BaseScreenState<TrainingDirectorReportsModel> {
  const TrainingDirectorReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingDirectorReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingDirectorReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
