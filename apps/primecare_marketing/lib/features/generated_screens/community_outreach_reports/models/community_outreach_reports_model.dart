import 'package:primecare_models/primecare_models.dart';

class CommunityOutreachReportsModel extends BaseScreenState<CommunityOutreachReportsModel> {
  const CommunityOutreachReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CommunityOutreachReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CommunityOutreachReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
