import 'package:primecare_models/primecare_models.dart';

class IntakeCoordinatorAssessmentsModel extends BaseScreenState<IntakeCoordinatorAssessmentsModel> {
  const IntakeCoordinatorAssessmentsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  IntakeCoordinatorAssessmentsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => IntakeCoordinatorAssessmentsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
