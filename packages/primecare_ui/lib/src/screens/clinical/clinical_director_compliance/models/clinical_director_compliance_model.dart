import 'package:primecare_models/primecare_models.dart';

class ClinicalDirectorComplianceModel extends BaseScreenState<ClinicalDirectorComplianceModel> {
  const ClinicalDirectorComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ClinicalDirectorComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ClinicalDirectorComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
