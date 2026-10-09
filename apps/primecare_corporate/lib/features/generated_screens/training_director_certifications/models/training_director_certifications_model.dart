import 'package:primecare_models/primecare_models.dart';

class TrainingDirectorCertificationsModel extends BaseScreenState<TrainingDirectorCertificationsModel> {
  const TrainingDirectorCertificationsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingDirectorCertificationsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingDirectorCertificationsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
