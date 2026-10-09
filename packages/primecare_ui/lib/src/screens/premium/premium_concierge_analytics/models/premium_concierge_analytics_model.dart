import 'package:primecare_models/primecare_models.dart';

class PremiumConciergeAnalyticsModel extends BaseScreenState<PremiumConciergeAnalyticsModel> {
  const PremiumConciergeAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PremiumConciergeAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PremiumConciergeAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
