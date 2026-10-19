import 'package:primecare_models/primecare_models.dart';

class CustomerSupportTicketsModel extends BaseScreenState<CustomerSupportTicketsModel> {
  const CustomerSupportTicketsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CustomerSupportTicketsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CustomerSupportTicketsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
