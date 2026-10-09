import 'package:primecare_models/primecare_models.dart';

class FinanceDirectorWorkflowModel extends BaseScreenState<FinanceDirectorWorkflowModel> {
  const FinanceDirectorWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FinanceDirectorWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FinanceDirectorWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
