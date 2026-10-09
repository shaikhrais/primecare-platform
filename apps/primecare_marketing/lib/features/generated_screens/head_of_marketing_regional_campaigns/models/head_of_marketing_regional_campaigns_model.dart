import 'package:primecare_models/primecare_models.dart';

class HeadOfMarketingRegionalCampaignsModel extends BaseScreenState<HeadOfMarketingRegionalCampaignsModel> {
  const HeadOfMarketingRegionalCampaignsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HeadOfMarketingRegionalCampaignsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HeadOfMarketingRegionalCampaignsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
