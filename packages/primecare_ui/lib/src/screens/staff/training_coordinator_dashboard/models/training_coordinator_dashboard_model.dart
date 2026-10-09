import 'package:primecare_models/primecare_models.dart';

class TrainingCoordinatorDashboardModel extends BaseScreenState<TrainingCoordinatorDashboardModel> {
  const TrainingCoordinatorDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingCoordinatorDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingCoordinatorDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
