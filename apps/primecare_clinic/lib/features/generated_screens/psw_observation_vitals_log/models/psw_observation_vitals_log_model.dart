import 'package:primecare_models/primecare_models.dart';

class PswObservationVitalsLogModel extends BaseScreenState<PswObservationVitalsLogModel> {
  const PswObservationVitalsLogModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PswObservationVitalsLogModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PswObservationVitalsLogModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
