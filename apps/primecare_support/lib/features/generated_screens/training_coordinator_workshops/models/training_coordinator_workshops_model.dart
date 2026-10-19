import 'package:primecare_models/primecare_models.dart';

class TrainingCoordinatorWorkshopsModel extends BaseScreenState<TrainingCoordinatorWorkshopsModel> {
  const TrainingCoordinatorWorkshopsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingCoordinatorWorkshopsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingCoordinatorWorkshopsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
