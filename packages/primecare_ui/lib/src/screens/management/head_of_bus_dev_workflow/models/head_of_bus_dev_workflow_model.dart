import 'package:primecare_models/primecare_models.dart';

class HeadOfBusDevWorkflowModel extends BaseScreenState<HeadOfBusDevWorkflowModel> {
  const HeadOfBusDevWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HeadOfBusDevWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HeadOfBusDevWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
