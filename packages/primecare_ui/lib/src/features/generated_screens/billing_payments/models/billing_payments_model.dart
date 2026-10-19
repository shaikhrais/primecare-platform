import 'package:primecare_models/primecare_models.dart';

class BillingPaymentsModel extends BaseScreenState<BillingPaymentsModel> {
  const BillingPaymentsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  BillingPaymentsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => BillingPaymentsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
