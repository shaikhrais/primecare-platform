import 'package:primecare_models/primecare_models.dart';

class BillingOverviewModel extends BaseScreenState<BillingOverviewModel> {
  const BillingOverviewModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  BillingOverviewModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => BillingOverviewModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
