import 'package:primecare_models/primecare_models.dart';

class RnFieldSupervisorWorkflowModel extends BaseScreenState<RnFieldSupervisorWorkflowModel> {
  const RnFieldSupervisorWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RnFieldSupervisorWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RnFieldSupervisorWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
