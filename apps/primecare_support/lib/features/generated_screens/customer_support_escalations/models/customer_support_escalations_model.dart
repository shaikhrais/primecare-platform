import 'package:primecare_models/primecare_models.dart';

class CustomerSupportEscalationsModel extends BaseScreenState<CustomerSupportEscalationsModel> {
  const CustomerSupportEscalationsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CustomerSupportEscalationsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CustomerSupportEscalationsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
