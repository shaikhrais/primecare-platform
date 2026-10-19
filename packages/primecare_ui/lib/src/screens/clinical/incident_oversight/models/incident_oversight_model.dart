import 'package:primecare_models/primecare_models.dart';

class IncidentOversightModel extends BaseScreenState<IncidentOversightModel> {
  const IncidentOversightModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  IncidentOversightModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => IncidentOversightModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
