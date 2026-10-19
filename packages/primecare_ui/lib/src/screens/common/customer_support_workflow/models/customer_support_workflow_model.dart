import 'package:primecare_models/primecare_models.dart';

class CustomerSupportWorkflowModel extends BaseScreenState<CustomerSupportWorkflowModel> {
  const CustomerSupportWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CustomerSupportWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CustomerSupportWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
