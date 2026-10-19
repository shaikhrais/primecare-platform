import 'package:primecare_models/primecare_models.dart';

class FranchiseSalesManagerWorkflowModel extends BaseScreenState<FranchiseSalesManagerWorkflowModel> {
  const FranchiseSalesManagerWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FranchiseSalesManagerWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FranchiseSalesManagerWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
