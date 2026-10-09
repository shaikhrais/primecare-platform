import 'package:primecare_models/primecare_models.dart';

class IncidentManagementModel extends BaseScreenState<IncidentManagementModel> {
  const IncidentManagementModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  IncidentManagementModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => IncidentManagementModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
