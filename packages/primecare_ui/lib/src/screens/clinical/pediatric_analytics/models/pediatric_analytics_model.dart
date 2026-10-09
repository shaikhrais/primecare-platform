import 'package:primecare_models/primecare_models.dart';

class PediatricAnalyticsModel extends BaseScreenState<PediatricAnalyticsModel> {
  const PediatricAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PediatricAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PediatricAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
