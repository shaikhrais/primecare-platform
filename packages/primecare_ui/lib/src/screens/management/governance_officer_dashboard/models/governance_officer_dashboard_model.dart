import 'package:primecare_models/primecare_models.dart';

class GovernanceOfficerDashboardModel extends BaseScreenState<GovernanceOfficerDashboardModel> {
  const GovernanceOfficerDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  GovernanceOfficerDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => GovernanceOfficerDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
