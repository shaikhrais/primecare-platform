import 'package:primecare_models/primecare_models.dart';

class LocalMarketingManagerCampaignsModel extends BaseScreenState<LocalMarketingManagerCampaignsModel> {
  const LocalMarketingManagerCampaignsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  LocalMarketingManagerCampaignsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => LocalMarketingManagerCampaignsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
