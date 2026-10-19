import 'package:primecare_models/primecare_models.dart';

class IntakeCoordinatorClientAssignmentModel extends BaseScreenState<IntakeCoordinatorClientAssignmentModel> {
  const IntakeCoordinatorClientAssignmentModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  IntakeCoordinatorClientAssignmentModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => IntakeCoordinatorClientAssignmentModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
