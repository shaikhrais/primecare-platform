import 'package:primecare_models/primecare_models.dart';

class MarketingManagerDashboardModel extends BaseScreenState<MarketingManagerDashboardModel> {
  const MarketingManagerDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  MarketingManagerDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => MarketingManagerDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
