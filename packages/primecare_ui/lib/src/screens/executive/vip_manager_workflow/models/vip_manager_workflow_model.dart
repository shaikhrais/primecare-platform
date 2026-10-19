import 'package:primecare_models/primecare_models.dart';

class VipManagerWorkflowModel extends BaseScreenState<VipManagerWorkflowModel> {
  const VipManagerWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  VipManagerWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => VipManagerWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
