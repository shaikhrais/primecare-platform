import 'package:primecare_models/primecare_models.dart';

class OfficeWorkflowModel extends BaseScreenState<OfficeWorkflowModel> {
  const OfficeWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  OfficeWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => OfficeWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
