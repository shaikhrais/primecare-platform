import 'package:primecare_models/primecare_models.dart';

class ReceptionistAppointmentsModel extends BaseScreenState<ReceptionistAppointmentsModel> {
  const ReceptionistAppointmentsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ReceptionistAppointmentsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ReceptionistAppointmentsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
