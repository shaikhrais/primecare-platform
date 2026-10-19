import 'package:primecare_models/primecare_models.dart';

class ComplianceTrainingTrackerModel extends BaseScreenState<ComplianceTrainingTrackerModel> {
  const ComplianceTrainingTrackerModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ComplianceTrainingTrackerModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ComplianceTrainingTrackerModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
