import 'package:primecare_models/primecare_models.dart';

class BillingAdminAnalyticsModel extends BaseScreenState<BillingAdminAnalyticsModel> {
  const BillingAdminAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  BillingAdminAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => BillingAdminAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
