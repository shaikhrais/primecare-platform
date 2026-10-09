import 'package:primecare_models/primecare_models.dart';

class VolunteerCoordinatorWorkflowModel extends BaseScreenState<VolunteerCoordinatorWorkflowModel> {
  const VolunteerCoordinatorWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  VolunteerCoordinatorWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => VolunteerCoordinatorWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
