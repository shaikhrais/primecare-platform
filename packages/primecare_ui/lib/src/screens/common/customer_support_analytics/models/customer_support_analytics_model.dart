import 'package:primecare_models/primecare_models.dart';

class CustomerSupportAnalyticsModel extends BaseScreenState<CustomerSupportAnalyticsModel> {
  const CustomerSupportAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CustomerSupportAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CustomerSupportAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
