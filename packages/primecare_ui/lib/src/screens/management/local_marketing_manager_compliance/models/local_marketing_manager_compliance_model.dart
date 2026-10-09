import 'package:primecare_models/primecare_models.dart';

class LocalMarketingManagerComplianceModel extends BaseScreenState<LocalMarketingManagerComplianceModel> {
  const LocalMarketingManagerComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  LocalMarketingManagerComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => LocalMarketingManagerComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
