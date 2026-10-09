import 'package:primecare_models/primecare_models.dart';

class CommunityHealthNeedsAssessmentModel extends BaseScreenState<CommunityHealthNeedsAssessmentModel> {
  const CommunityHealthNeedsAssessmentModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CommunityHealthNeedsAssessmentModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CommunityHealthNeedsAssessmentModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
