import 'package:primecare_models/primecare_models.dart';

class CustomerSupportDashboardModel extends BaseScreenState<CustomerSupportDashboardModel> {
  const CustomerSupportDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CustomerSupportDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CustomerSupportDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
