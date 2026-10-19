import 'package:primecare_models/primecare_models.dart';

class AppointmentModel extends BaseScreenState<AppointmentModel> {
  const AppointmentModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  AppointmentModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => AppointmentModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
