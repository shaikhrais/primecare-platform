import 'package:primecare_models/primecare_models.dart';

class CustomerSupportTemplatesModel extends BaseScreenState<CustomerSupportTemplatesModel> {
  const CustomerSupportTemplatesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CustomerSupportTemplatesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CustomerSupportTemplatesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
