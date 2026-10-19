import 'package:primecare_models/primecare_models.dart';

class TrainingDirectorDashboardModel extends BaseScreenState<TrainingDirectorDashboardModel> {
  const TrainingDirectorDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingDirectorDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingDirectorDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
