import 'package:primecare_models/primecare_models.dart';

class CustomerSupportComplianceModel extends BaseScreenState<CustomerSupportComplianceModel> {
  const CustomerSupportComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CustomerSupportComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CustomerSupportComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
