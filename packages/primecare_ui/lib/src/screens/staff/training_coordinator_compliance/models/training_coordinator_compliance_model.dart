import 'package:primecare_models/primecare_models.dart';

class TrainingCoordinatorComplianceModel extends BaseScreenState<TrainingCoordinatorComplianceModel> {
  const TrainingCoordinatorComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingCoordinatorComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingCoordinatorComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
