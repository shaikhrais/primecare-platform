import 'package:primecare_models/primecare_models.dart';

class TrainingDirectorCertificatesModel extends BaseScreenState<TrainingDirectorCertificatesModel> {
  const TrainingDirectorCertificatesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingDirectorCertificatesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingDirectorCertificatesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
