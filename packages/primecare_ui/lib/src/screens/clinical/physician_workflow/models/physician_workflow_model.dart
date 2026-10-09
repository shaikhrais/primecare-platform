import 'package:primecare_models/primecare_models.dart';

class PhysicianWorkflowModel extends BaseScreenState<PhysicianWorkflowModel> {
  const PhysicianWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PhysicianWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PhysicianWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
