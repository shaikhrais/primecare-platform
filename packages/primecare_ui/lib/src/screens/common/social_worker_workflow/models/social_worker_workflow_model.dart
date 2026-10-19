import 'package:primecare_models/primecare_models.dart';

class SocialWorkerWorkflowModel extends BaseScreenState<SocialWorkerWorkflowModel> {
  const SocialWorkerWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SocialWorkerWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SocialWorkerWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
