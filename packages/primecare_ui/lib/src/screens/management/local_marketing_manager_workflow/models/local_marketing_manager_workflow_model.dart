import 'package:primecare_models/primecare_models.dart';

class LocalMarketingManagerWorkflowModel extends BaseScreenState<LocalMarketingManagerWorkflowModel> {
  const LocalMarketingManagerWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  LocalMarketingManagerWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => LocalMarketingManagerWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
