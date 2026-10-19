import 'package:primecare_models/primecare_models.dart';

class ClinicalDirectorStaffQualityModel extends BaseScreenState<ClinicalDirectorStaffQualityModel> {
  const ClinicalDirectorStaffQualityModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ClinicalDirectorStaffQualityModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ClinicalDirectorStaffQualityModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
