import 'package:primecare_models/primecare_models.dart';

class PatientBookAppointmentModel extends BaseScreenState<PatientBookAppointmentModel> {
  const PatientBookAppointmentModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PatientBookAppointmentModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PatientBookAppointmentModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
