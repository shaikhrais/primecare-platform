import 'package:primecare_models/primecare_models.dart';

class HeadOfMarketingFunnelAnalyticsModel extends BaseScreenState<HeadOfMarketingFunnelAnalyticsModel> {
  const HeadOfMarketingFunnelAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HeadOfMarketingFunnelAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HeadOfMarketingFunnelAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
