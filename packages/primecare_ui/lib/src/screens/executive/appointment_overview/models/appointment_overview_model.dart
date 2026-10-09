import 'package:primecare_models/primecare_models.dart';

class AppointmentOverviewModel extends BaseScreenState<AppointmentOverviewModel> {
  const AppointmentOverviewModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  AppointmentOverviewModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => AppointmentOverviewModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
