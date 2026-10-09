import 'package:primecare_models/primecare_models.dart';

class ChiropractorAnalyticsModel extends BaseScreenState<ChiropractorAnalyticsModel> {
  const ChiropractorAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ChiropractorAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ChiropractorAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
