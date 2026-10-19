import 'package:primecare_models/primecare_models.dart';

class CommunityOutreachWorkflowModel extends BaseScreenState<CommunityOutreachWorkflowModel> {
  const CommunityOutreachWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CommunityOutreachWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CommunityOutreachWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
