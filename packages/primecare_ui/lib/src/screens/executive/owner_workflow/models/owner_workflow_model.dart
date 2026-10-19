import 'package:primecare_models/primecare_models.dart';

class OwnerWorkflowModel extends BaseScreenState<OwnerWorkflowModel> {
  const OwnerWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  OwnerWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => OwnerWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
