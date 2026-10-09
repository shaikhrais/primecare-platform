import 'package:primecare_models/primecare_models.dart';

class TrainingDirectorHubModel extends BaseScreenState<TrainingDirectorHubModel> {
  const TrainingDirectorHubModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingDirectorHubModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingDirectorHubModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
