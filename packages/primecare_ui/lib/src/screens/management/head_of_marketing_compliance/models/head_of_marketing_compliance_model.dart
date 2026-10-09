import 'package:primecare_models/primecare_models.dart';

class HeadOfMarketingComplianceModel extends BaseScreenState<HeadOfMarketingComplianceModel> {
  const HeadOfMarketingComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HeadOfMarketingComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HeadOfMarketingComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
