import 'package:primecare_models/primecare_models.dart';

class ClinicalAnalyticsModel extends BaseScreenState<ClinicalAnalyticsModel> {
  const ClinicalAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ClinicalAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ClinicalAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
