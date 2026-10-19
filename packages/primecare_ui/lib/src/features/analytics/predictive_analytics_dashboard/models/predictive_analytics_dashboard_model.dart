import 'package:primecare_models/primecare_models.dart';

class PredictiveAnalyticsDashboardModel extends BaseScreenState<PredictiveAnalyticsDashboardModel> {
  const PredictiveAnalyticsDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PredictiveAnalyticsDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PredictiveAnalyticsDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
