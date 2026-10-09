import 'package:primecare_models/primecare_models.dart';

class TrainingCoordinatorReportsModel extends BaseScreenState<TrainingCoordinatorReportsModel> {
  const TrainingCoordinatorReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingCoordinatorReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingCoordinatorReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
