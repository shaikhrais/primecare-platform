import 'package:primecare_models/primecare_models.dart';

class FranchiseWorkflowModel extends BaseScreenState<FranchiseWorkflowModel> {
  const FranchiseWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FranchiseWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FranchiseWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
