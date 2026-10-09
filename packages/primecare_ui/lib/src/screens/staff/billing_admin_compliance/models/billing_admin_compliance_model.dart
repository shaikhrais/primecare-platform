import 'package:primecare_models/primecare_models.dart';

class BillingAdminComplianceModel extends BaseScreenState<BillingAdminComplianceModel> {
  const BillingAdminComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  BillingAdminComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => BillingAdminComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
