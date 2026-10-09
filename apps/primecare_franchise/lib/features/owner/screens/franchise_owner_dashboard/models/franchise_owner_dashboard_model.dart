import 'package:primecare_models/primecare_models.dart';

class FranchiseOwnerDashboardModel extends BaseScreenState<FranchiseOwnerDashboardModel> {
  const FranchiseOwnerDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FranchiseOwnerDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FranchiseOwnerDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
