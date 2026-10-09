import 'package:primecare_models/primecare_models.dart';

class FranchiseSalesManagerDashboardModel extends BaseScreenState<FranchiseSalesManagerDashboardModel> {
  const FranchiseSalesManagerDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FranchiseSalesManagerDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FranchiseSalesManagerDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
