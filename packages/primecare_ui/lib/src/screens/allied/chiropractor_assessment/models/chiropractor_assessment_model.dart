import 'package:primecare_models/primecare_models.dart';

class ChiropractorAssessmentModel extends BaseScreenState<ChiropractorAssessmentModel> {
  const ChiropractorAssessmentModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ChiropractorAssessmentModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ChiropractorAssessmentModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
