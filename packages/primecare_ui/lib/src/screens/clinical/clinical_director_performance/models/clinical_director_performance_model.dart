import 'package:primecare_models/primecare_models.dart';

class ClinicalDirectorPerformanceModel extends BaseScreenState<ClinicalDirectorPerformanceModel> {
  const ClinicalDirectorPerformanceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ClinicalDirectorPerformanceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ClinicalDirectorPerformanceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
