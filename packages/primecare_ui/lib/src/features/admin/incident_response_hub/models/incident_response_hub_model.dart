import 'package:primecare_models/primecare_models.dart';

class IncidentResponseHubModel extends BaseScreenState<IncidentResponseHubModel> {
  const IncidentResponseHubModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  IncidentResponseHubModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => IncidentResponseHubModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
