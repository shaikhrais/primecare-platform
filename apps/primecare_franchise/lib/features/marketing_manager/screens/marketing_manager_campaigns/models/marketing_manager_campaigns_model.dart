import 'package:primecare_models/primecare_models.dart';

class MarketingManagerCampaignsModel extends BaseScreenState<MarketingManagerCampaignsModel> {
  const MarketingManagerCampaignsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  MarketingManagerCampaignsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => MarketingManagerCampaignsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
