import 'package:primecare_models/primecare_models.dart';

class BusinessDevelopmentComplianceModel extends BaseScreenState<BusinessDevelopmentComplianceModel> {
  const BusinessDevelopmentComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  BusinessDevelopmentComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => BusinessDevelopmentComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
