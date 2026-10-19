import 'package:primecare_models/primecare_models.dart';

class ClinicalDirectorReportsModel extends BaseScreenState<ClinicalDirectorReportsModel> {
  const ClinicalDirectorReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ClinicalDirectorReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ClinicalDirectorReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
