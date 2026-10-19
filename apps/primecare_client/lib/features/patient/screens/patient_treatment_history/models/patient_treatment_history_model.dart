import 'package:primecare_models/primecare_models.dart';

class PatientTreatmentHistoryModel extends BaseScreenState<PatientTreatmentHistoryModel> {
  const PatientTreatmentHistoryModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PatientTreatmentHistoryModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PatientTreatmentHistoryModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
