import 'package:primecare_models/primecare_models.dart';

class GovernanceOfficerAnalyticsModel extends BaseScreenState<GovernanceOfficerAnalyticsModel> {
  const GovernanceOfficerAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  GovernanceOfficerAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => GovernanceOfficerAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
