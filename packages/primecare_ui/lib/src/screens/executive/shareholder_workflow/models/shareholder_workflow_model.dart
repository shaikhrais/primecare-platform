import 'package:primecare_models/primecare_models.dart';

class ShareholderWorkflowModel extends BaseScreenState<ShareholderWorkflowModel> {
  const ShareholderWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ShareholderWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ShareholderWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
