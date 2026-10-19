import 'package:primecare_models/primecare_models.dart';

class QualityAssuranceComplianceChecksModel extends BaseScreenState<QualityAssuranceComplianceChecksModel> {
  const QualityAssuranceComplianceChecksModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  QualityAssuranceComplianceChecksModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => QualityAssuranceComplianceChecksModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
