import 'package:primecare_models/primecare_models.dart';

class GuestWorkflowModel extends BaseScreenState<GuestWorkflowModel> {
  const GuestWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  GuestWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => GuestWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
