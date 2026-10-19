import 'package:primecare_models/primecare_models.dart';

class IntakeCoordinatorAssessmentQueueModel extends BaseScreenState<IntakeCoordinatorAssessmentQueueModel> {
  const IntakeCoordinatorAssessmentQueueModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  IntakeCoordinatorAssessmentQueueModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => IntakeCoordinatorAssessmentQueueModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
