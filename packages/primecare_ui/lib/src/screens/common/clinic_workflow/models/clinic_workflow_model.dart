import 'package:primecare_models/primecare_models.dart';

class ClinicWorkflowModel extends BaseScreenState<ClinicWorkflowModel> {
  const ClinicWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ClinicWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ClinicWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
