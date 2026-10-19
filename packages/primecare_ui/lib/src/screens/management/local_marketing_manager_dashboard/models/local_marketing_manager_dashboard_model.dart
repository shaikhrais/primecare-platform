import 'package:primecare_models/primecare_models.dart';

class LocalMarketingManagerDashboardModel extends BaseScreenState<LocalMarketingManagerDashboardModel> {
  const LocalMarketingManagerDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  LocalMarketingManagerDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => LocalMarketingManagerDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
