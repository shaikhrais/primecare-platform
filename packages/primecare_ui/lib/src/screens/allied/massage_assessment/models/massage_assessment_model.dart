import 'package:primecare_models/primecare_models.dart';

class MassageAssessmentModel extends BaseScreenState<MassageAssessmentModel> {
  const MassageAssessmentModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  MassageAssessmentModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => MassageAssessmentModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
