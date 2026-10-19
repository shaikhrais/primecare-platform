import 'package:primecare_models/primecare_models.dart';

class HeadOfMarketingCampaignsModel extends BaseScreenState<HeadOfMarketingCampaignsModel> {
  const HeadOfMarketingCampaignsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HeadOfMarketingCampaignsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HeadOfMarketingCampaignsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
