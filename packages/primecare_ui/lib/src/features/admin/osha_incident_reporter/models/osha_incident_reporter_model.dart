import 'package:primecare_models/primecare_models.dart';

class OshaIncidentReporterModel extends BaseScreenState<OshaIncidentReporterModel> {
  const OshaIncidentReporterModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  OshaIncidentReporterModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => OshaIncidentReporterModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
