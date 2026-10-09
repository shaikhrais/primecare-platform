import 'package:primecare_models/primecare_models.dart';

class HrHiringWorkflowModel extends BaseScreenState<HrHiringWorkflowModel> {
  const HrHiringWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HrHiringWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HrHiringWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
