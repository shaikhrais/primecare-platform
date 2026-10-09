import 'package:primecare_models/primecare_models.dart';

class PatientAppointmentsModel extends BaseScreenState<PatientAppointmentsModel> {
  const PatientAppointmentsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PatientAppointmentsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PatientAppointmentsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
