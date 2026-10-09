import 'package:primecare_models/primecare_models.dart';

class CaregiverIncidentReportModel extends BaseScreenState<CaregiverIncidentReportModel> {
  const CaregiverIncidentReportModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CaregiverIncidentReportModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CaregiverIncidentReportModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
