import 'package:primecare_models/primecare_models.dart';

class PortalWorkflowModel extends BaseScreenState<PortalWorkflowModel> {
  const PortalWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PortalWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PortalWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
