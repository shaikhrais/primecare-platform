import 'package:primecare_models/primecare_models.dart';

class BusinessDevelopmentWorkflowModel extends BaseScreenState<BusinessDevelopmentWorkflowModel> {
  const BusinessDevelopmentWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  BusinessDevelopmentWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => BusinessDevelopmentWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
