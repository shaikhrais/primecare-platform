import 'package:primecare_models/primecare_models.dart';

class TrainingCoordinatorAnalyticsModel extends BaseScreenState<TrainingCoordinatorAnalyticsModel> {
  const TrainingCoordinatorAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingCoordinatorAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingCoordinatorAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
