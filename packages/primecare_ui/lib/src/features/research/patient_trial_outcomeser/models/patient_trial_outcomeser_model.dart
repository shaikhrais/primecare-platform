import 'package:primecare_models/primecare_models.dart';

class PatientTrialOutcomeserModel extends BaseScreenState<PatientTrialOutcomeserModel> {
  const PatientTrialOutcomeserModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PatientTrialOutcomeserModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PatientTrialOutcomeserModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
