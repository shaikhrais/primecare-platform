import 'package:primecare_models/primecare_models.dart';

class TrainingDirectorAnalyticsModel extends BaseScreenState<TrainingDirectorAnalyticsModel> {
  const TrainingDirectorAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingDirectorAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingDirectorAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
