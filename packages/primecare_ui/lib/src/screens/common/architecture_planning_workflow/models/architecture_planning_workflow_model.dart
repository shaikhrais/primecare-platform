import 'package:primecare_models/primecare_models.dart';

class ArchitecturePlanningWorkflowModel extends BaseScreenState<ArchitecturePlanningWorkflowModel> {
  const ArchitecturePlanningWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ArchitecturePlanningWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ArchitecturePlanningWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
