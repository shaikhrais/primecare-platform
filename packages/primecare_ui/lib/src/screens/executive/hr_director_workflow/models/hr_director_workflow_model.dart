import 'package:primecare_models/primecare_models.dart';

class HrDirectorWorkflowModel extends BaseScreenState<HrDirectorWorkflowModel> {
  const HrDirectorWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HrDirectorWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HrDirectorWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
