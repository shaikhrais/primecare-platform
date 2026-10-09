import 'package:primecare_models/primecare_models.dart';

class PhysiotherapistWorkflowModel extends BaseScreenState<PhysiotherapistWorkflowModel> {
  const PhysiotherapistWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PhysiotherapistWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PhysiotherapistWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
