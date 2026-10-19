import 'package:primecare_models/primecare_models.dart';

class ChiropractorExercisePlanModel extends BaseScreenState<ChiropractorExercisePlanModel> {
  const ChiropractorExercisePlanModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ChiropractorExercisePlanModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ChiropractorExercisePlanModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
