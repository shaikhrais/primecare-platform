import 'package:primecare_models/primecare_models.dart';

class EmployeeWorkflowModel extends BaseScreenState<EmployeeWorkflowModel> {
  const EmployeeWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  EmployeeWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => EmployeeWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
