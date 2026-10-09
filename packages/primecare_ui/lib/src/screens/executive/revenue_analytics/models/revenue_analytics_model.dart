import 'package:primecare_models/primecare_models.dart';

class RevenueAnalyticsModel extends BaseScreenState<RevenueAnalyticsModel> {
  const RevenueAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RevenueAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RevenueAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
