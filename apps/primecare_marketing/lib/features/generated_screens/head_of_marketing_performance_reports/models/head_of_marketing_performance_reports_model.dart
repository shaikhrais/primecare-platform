import 'package:primecare_models/primecare_models.dart';

class HeadOfMarketingPerformanceReportsModel extends BaseScreenState<HeadOfMarketingPerformanceReportsModel> {
  const HeadOfMarketingPerformanceReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HeadOfMarketingPerformanceReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HeadOfMarketingPerformanceReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
