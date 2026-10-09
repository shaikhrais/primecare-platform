import 'package:primecare_models/primecare_models.dart';

class LocalMarketingManagerAnalyticsModel extends BaseScreenState<LocalMarketingManagerAnalyticsModel> {
  const LocalMarketingManagerAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  LocalMarketingManagerAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => LocalMarketingManagerAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
