import 'package:primecare_models/primecare_models.dart';

class BillingClaimsModel extends BaseScreenState<BillingClaimsModel> {
  const BillingClaimsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  BillingClaimsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => BillingClaimsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
