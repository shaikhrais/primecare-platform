import 'package:primecare_models/primecare_models.dart';

class ClientMyAppointmentsModel extends BaseScreenState<ClientMyAppointmentsModel> {
  const ClientMyAppointmentsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ClientMyAppointmentsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ClientMyAppointmentsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
