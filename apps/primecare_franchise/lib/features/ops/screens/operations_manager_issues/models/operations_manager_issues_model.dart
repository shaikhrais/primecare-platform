import 'package:primecare_models/primecare_models.dart';

class OperationsManagerIssuesModel extends BaseScreenState<OperationsManagerIssuesModel> {
  const OperationsManagerIssuesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  OperationsManagerIssuesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => OperationsManagerIssuesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
