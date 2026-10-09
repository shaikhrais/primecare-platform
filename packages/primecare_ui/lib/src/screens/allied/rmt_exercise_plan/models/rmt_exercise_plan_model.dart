import 'package:primecare_models/primecare_models.dart';

class RmtExercisePlanModel extends BaseScreenState<RmtExercisePlanModel> {
  const RmtExercisePlanModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RmtExercisePlanModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RmtExercisePlanModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
