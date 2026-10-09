import 'package:primecare_models/primecare_models.dart';

class PatientObservationModel extends BaseScreenState<PatientObservationModel> {
  const PatientObservationModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PatientObservationModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PatientObservationModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
