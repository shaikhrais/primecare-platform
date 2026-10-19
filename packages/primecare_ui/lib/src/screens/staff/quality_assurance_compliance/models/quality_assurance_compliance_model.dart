import 'package:primecare_models/primecare_models.dart';

class QualityAssuranceComplianceModel extends BaseScreenState<QualityAssuranceComplianceModel> {
  const QualityAssuranceComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  QualityAssuranceComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => QualityAssuranceComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
