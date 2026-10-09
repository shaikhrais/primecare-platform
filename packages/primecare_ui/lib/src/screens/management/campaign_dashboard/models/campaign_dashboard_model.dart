import 'package:primecare_models/primecare_models.dart';

class CampaignDashboardModel extends BaseScreenState<CampaignDashboardModel> {
  const CampaignDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CampaignDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CampaignDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
