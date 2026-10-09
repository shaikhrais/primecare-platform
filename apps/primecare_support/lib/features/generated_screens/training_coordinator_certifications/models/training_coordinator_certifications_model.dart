import 'package:primecare_models/primecare_models.dart';

class TrainingCoordinatorCertificationsModel extends BaseScreenState<TrainingCoordinatorCertificationsModel> {
  const TrainingCoordinatorCertificationsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingCoordinatorCertificationsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingCoordinatorCertificationsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
