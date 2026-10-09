import 'package:primecare_models/primecare_models.dart';

class PatientMyAppointmentsModel extends BaseScreenState<PatientMyAppointmentsModel> {
  const PatientMyAppointmentsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PatientMyAppointmentsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PatientMyAppointmentsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
