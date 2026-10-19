import 'package:primecare_models/primecare_models.dart';

class TrainingHubModel extends BaseScreenState<TrainingHubModel> {
  const TrainingHubModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingHubModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingHubModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
