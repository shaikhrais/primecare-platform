import 'package:primecare_models/primecare_models.dart';

class IncidentReportsModel extends BaseScreenState<IncidentReportsModel> {
  const IncidentReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  IncidentReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => IncidentReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
