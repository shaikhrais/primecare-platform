import 'package:primecare_models/primecare_models.dart';

class SupportAnalyticsModel extends BaseScreenState<SupportAnalyticsModel> {
  const SupportAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SupportAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SupportAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
