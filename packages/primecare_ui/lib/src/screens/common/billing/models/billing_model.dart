import 'package:primecare_models/primecare_models.dart';

class BillingModel extends BaseScreenState<BillingModel> {
  const BillingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  BillingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => BillingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
