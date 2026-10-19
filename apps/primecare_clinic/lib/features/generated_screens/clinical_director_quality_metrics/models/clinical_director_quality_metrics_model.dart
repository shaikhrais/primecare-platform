import 'package:primecare_models/primecare_models.dart';

class ClinicalDirectorQualityMetricsModel extends BaseScreenState<ClinicalDirectorQualityMetricsModel> {
  const ClinicalDirectorQualityMetricsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ClinicalDirectorQualityMetricsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ClinicalDirectorQualityMetricsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
