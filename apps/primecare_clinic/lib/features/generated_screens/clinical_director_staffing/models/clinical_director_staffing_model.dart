import 'package:primecare_models/primecare_models.dart';

class ClinicalDirectorStaffingModel extends BaseScreenState<ClinicalDirectorStaffingModel> {
  const ClinicalDirectorStaffingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ClinicalDirectorStaffingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ClinicalDirectorStaffingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
