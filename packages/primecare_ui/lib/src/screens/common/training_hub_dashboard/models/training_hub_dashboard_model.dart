import 'package:primecare_models/primecare_models.dart';

class TrainingHubDashboardModel extends BaseScreenState<TrainingHubDashboardModel> {
  const TrainingHubDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingHubDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingHubDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
