import 'package:primecare_models/primecare_models.dart';

class BillingAdminInvoicesModel extends BaseScreenState<BillingAdminInvoicesModel> {
  const BillingAdminInvoicesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  BillingAdminInvoicesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => BillingAdminInvoicesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
