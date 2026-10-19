import 'package:primecare_models/primecare_models.dart';

class PatientCareTeamModel extends BaseScreenState<PatientCareTeamModel> {
  const PatientCareTeamModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PatientCareTeamModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PatientCareTeamModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
