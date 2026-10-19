import 'package:primecare_models/primecare_models.dart';

class IntakeCoordinatorWorkflowModel extends BaseScreenState<IntakeCoordinatorWorkflowModel> {
  const IntakeCoordinatorWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  IntakeCoordinatorWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => IntakeCoordinatorWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
