import 'package:primecare_models/primecare_models.dart';

class ChiropractorAppointmentsModel extends BaseScreenState<ChiropractorAppointmentsModel> {
  const ChiropractorAppointmentsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ChiropractorAppointmentsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ChiropractorAppointmentsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
