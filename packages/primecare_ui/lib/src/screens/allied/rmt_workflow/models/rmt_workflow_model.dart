import 'package:primecare_models/primecare_models.dart';

class RmtWorkflowModel extends BaseScreenState<RmtWorkflowModel> {
  const RmtWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RmtWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RmtWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
