import 'package:primecare_models/primecare_models.dart';

class TrainingDirectorComplianceModel extends BaseScreenState<TrainingDirectorComplianceModel> {
  const TrainingDirectorComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingDirectorComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingDirectorComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
