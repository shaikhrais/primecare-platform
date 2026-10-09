import 'package:primecare_models/primecare_models.dart';

class TrainingAnalyticsModel extends BaseScreenState<TrainingAnalyticsModel> {
  const TrainingAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
