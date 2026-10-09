import 'package:primecare_models/primecare_models.dart';

class ClinicIncidentReportModel extends BaseScreenState<ClinicIncidentReportModel> {
  const ClinicIncidentReportModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ClinicIncidentReportModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ClinicIncidentReportModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
