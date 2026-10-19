import 'package:primecare_models/primecare_models.dart';

class TrainingCoordinatorMaterialsModel extends BaseScreenState<TrainingCoordinatorMaterialsModel> {
  const TrainingCoordinatorMaterialsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingCoordinatorMaterialsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingCoordinatorMaterialsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
