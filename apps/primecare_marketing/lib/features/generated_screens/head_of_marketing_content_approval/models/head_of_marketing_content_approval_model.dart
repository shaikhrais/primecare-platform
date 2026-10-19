import 'package:primecare_models/primecare_models.dart';

class HeadOfMarketingContentApprovalModel extends BaseScreenState<HeadOfMarketingContentApprovalModel> {
  const HeadOfMarketingContentApprovalModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HeadOfMarketingContentApprovalModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HeadOfMarketingContentApprovalModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
