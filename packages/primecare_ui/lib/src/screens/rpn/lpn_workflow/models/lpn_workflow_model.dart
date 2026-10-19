import 'package:primecare_models/primecare_models.dart';

class LpnWorkflowModel extends BaseScreenState<LpnWorkflowModel> {
  const LpnWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  LpnWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => LpnWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
