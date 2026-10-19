import 'package:primecare_models/primecare_models.dart';

class RmtAssessmentModel extends BaseScreenState<RmtAssessmentModel> {
  const RmtAssessmentModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RmtAssessmentModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RmtAssessmentModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
