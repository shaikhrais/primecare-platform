import 'package:primecare_models/primecare_models.dart';

class CustomerSupportReportsModel extends BaseScreenState<CustomerSupportReportsModel> {
  const CustomerSupportReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CustomerSupportReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CustomerSupportReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
