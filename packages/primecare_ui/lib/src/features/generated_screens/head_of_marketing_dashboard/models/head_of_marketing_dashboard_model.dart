import 'package:primecare_models/primecare_models.dart';

class HeadOfMarketingDashboardModel extends BaseScreenState<HeadOfMarketingDashboardModel> {
  const HeadOfMarketingDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HeadOfMarketingDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HeadOfMarketingDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
