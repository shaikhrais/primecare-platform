import 'package:primecare_models/primecare_models.dart';

class PhysiotherapistAssessmentModel extends BaseScreenState<PhysiotherapistAssessmentModel> {
  const PhysiotherapistAssessmentModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PhysiotherapistAssessmentModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PhysiotherapistAssessmentModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
