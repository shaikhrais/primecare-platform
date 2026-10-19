import 'package:primecare_models/primecare_models.dart';

class PhysiotherapistExercisePlanModel extends BaseScreenState<PhysiotherapistExercisePlanModel> {
  const PhysiotherapistExercisePlanModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PhysiotherapistExercisePlanModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PhysiotherapistExercisePlanModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
