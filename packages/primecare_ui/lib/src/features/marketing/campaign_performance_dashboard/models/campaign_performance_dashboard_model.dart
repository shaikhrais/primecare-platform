import 'package:primecare_models/primecare_models.dart';

class CampaignPerformanceDashboardModel extends BaseScreenState<CampaignPerformanceDashboardModel> {
  const CampaignPerformanceDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CampaignPerformanceDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CampaignPerformanceDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
