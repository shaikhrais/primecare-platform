import 'package:primecare_models/primecare_models.dart';

class BillingInvoicesModel extends BaseScreenState<BillingInvoicesModel> {
  const BillingInvoicesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  BillingInvoicesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => BillingInvoicesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
