import 'package:primecare_models/primecare_models.dart';

class BillingAdminWorkflowModel extends BaseScreenState<BillingAdminWorkflowModel> {
  const BillingAdminWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  BillingAdminWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => BillingAdminWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
