import 'package:primecare_models/primecare_models.dart';

class NpAnalyticsModel extends BaseScreenState<NpAnalyticsModel> {
  const NpAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  NpAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => NpAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
