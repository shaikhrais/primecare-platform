import 'package:primecare_models/primecare_models.dart';

class ClinicalQualityModel extends BaseScreenState<ClinicalQualityModel> {
  const ClinicalQualityModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ClinicalQualityModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ClinicalQualityModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
