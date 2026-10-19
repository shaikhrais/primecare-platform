import 'package:primecare_models/primecare_models.dart';

class ChiropracticAssessmentModel extends BaseScreenState<ChiropracticAssessmentModel> {
  const ChiropracticAssessmentModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ChiropracticAssessmentModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ChiropracticAssessmentModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
