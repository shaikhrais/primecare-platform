import 'package:primecare_models/primecare_models.dart';

class GovernanceHudModel extends BaseScreenState<GovernanceHudModel> {
  const GovernanceHudModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  GovernanceHudModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => GovernanceHudModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
