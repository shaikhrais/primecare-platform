import 'package:primecare_models/primecare_models.dart';

class HeadOfMarketingWorkflowModel extends BaseScreenState<HeadOfMarketingWorkflowModel> {
  const HeadOfMarketingWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HeadOfMarketingWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HeadOfMarketingWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
