import 'package:primecare_models/primecare_models.dart';

class GovernanceOperations4KModel extends BaseScreenState<GovernanceOperations4KModel> {
  const GovernanceOperations4KModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  GovernanceOperations4KModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => GovernanceOperations4KModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
