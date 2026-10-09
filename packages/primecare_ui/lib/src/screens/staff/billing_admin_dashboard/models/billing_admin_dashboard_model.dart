import 'package:primecare_models/primecare_models.dart';

class BillingAdminDashboardModel extends BaseScreenState<BillingAdminDashboardModel> {
  const BillingAdminDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  BillingAdminDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => BillingAdminDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
