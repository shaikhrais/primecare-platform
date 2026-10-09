import 'package:primecare_models/primecare_models.dart';

class ProviderPerformanceDashboardModel extends BaseScreenState<ProviderPerformanceDashboardModel> {
  const ProviderPerformanceDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ProviderPerformanceDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ProviderPerformanceDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
