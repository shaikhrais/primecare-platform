import 'package:primecare_models/primecare_models.dart';

class TrainingHubComplianceModel extends BaseScreenState<TrainingHubComplianceModel> {
  const TrainingHubComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingHubComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingHubComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
