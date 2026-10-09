import 'package:primecare_models/primecare_models.dart';

class CommunityOutreachAnalyticsModel extends BaseScreenState<CommunityOutreachAnalyticsModel> {
  const CommunityOutreachAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CommunityOutreachAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CommunityOutreachAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
