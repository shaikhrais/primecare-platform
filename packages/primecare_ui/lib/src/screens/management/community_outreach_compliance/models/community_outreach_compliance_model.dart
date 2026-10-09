import 'package:primecare_models/primecare_models.dart';

class CommunityOutreachComplianceModel extends BaseScreenState<CommunityOutreachComplianceModel> {
  const CommunityOutreachComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CommunityOutreachComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CommunityOutreachComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
