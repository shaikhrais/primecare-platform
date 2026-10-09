import 'package:primecare_models/primecare_models.dart';

class ReceptionistWorkflowModel extends BaseScreenState<ReceptionistWorkflowModel> {
  const ReceptionistWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ReceptionistWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ReceptionistWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
