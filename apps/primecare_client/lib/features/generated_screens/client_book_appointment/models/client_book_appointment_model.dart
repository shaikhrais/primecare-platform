import 'package:primecare_models/primecare_models.dart';

class ClientBookAppointmentModel extends BaseScreenState<ClientBookAppointmentModel> {
  const ClientBookAppointmentModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ClientBookAppointmentModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ClientBookAppointmentModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
