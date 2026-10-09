import 'package:primecare_models/primecare_models.dart';

class FranchiseSalesWorkflowModel extends BaseScreenState<FranchiseSalesWorkflowModel> {
  const FranchiseSalesWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FranchiseSalesWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FranchiseSalesWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
