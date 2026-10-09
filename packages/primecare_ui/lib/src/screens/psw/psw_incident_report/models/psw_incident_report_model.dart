import 'package:primecare_models/primecare_models.dart';

class PswIncidentReportModel extends BaseScreenState<PswIncidentReportModel> {
  const PswIncidentReportModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PswIncidentReportModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PswIncidentReportModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
