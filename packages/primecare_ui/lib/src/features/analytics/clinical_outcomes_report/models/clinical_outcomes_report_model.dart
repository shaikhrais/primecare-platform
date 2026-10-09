import 'package:primecare_models/primecare_models.dart';

class ClinicalOutcomesReportModel extends BaseScreenState<ClinicalOutcomesReportModel> {
  const ClinicalOutcomesReportModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ClinicalOutcomesReportModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ClinicalOutcomesReportModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
