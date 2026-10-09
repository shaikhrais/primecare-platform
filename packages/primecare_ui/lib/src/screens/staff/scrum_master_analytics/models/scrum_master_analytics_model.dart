import 'package:primecare_models/primecare_models.dart';

class ScrumMasterAnalyticsModel extends BaseScreenState<ScrumMasterAnalyticsModel> {
  const ScrumMasterAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ScrumMasterAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ScrumMasterAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
