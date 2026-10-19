import 'package:primecare_models/primecare_models.dart';

class ExercisePrescriptionModel extends BaseScreenState<ExercisePrescriptionModel> {
  const ExercisePrescriptionModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ExercisePrescriptionModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ExercisePrescriptionModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
