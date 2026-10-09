import 'package:primecare_models/primecare_models.dart';

class SecurityIncidentModel extends BaseScreenState<SecurityIncidentModel> {
  const SecurityIncidentModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SecurityIncidentModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SecurityIncidentModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
