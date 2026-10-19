import 'package:primecare_models/primecare_models.dart';

class TrainingCoordinatorProgressModel extends BaseScreenState<TrainingCoordinatorProgressModel> {
  const TrainingCoordinatorProgressModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingCoordinatorProgressModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingCoordinatorProgressModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
