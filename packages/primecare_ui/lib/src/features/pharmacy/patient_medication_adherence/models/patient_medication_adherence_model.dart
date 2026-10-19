import 'package:primecare_models/primecare_models.dart';

class PatientMedicationAdherenceModel extends BaseScreenState<PatientMedicationAdherenceModel> {
  const PatientMedicationAdherenceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PatientMedicationAdherenceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PatientMedicationAdherenceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
