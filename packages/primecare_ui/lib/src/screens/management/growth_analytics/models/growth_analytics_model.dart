import 'package:primecare_models/primecare_models.dart';

class GrowthAnalyticsModel extends BaseScreenState<GrowthAnalyticsModel> {
  const GrowthAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  GrowthAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => GrowthAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
