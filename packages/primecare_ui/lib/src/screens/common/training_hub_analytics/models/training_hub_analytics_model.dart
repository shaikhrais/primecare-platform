import 'package:primecare_models/primecare_models.dart';

class TrainingHubAnalyticsModel extends BaseScreenState<TrainingHubAnalyticsModel> {
  const TrainingHubAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingHubAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingHubAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
