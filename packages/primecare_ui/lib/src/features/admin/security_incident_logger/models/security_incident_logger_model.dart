import 'package:primecare_models/primecare_models.dart';

class SecurityIncidentLoggerModel extends BaseScreenState<SecurityIncidentLoggerModel> {
  const SecurityIncidentLoggerModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SecurityIncidentLoggerModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SecurityIncidentLoggerModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
