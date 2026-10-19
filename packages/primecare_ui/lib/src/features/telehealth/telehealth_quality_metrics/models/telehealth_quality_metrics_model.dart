import 'package:primecare_models/primecare_models.dart';

class TelehealthQualityMetricsModel extends BaseScreenState<TelehealthQualityMetricsModel> {
  const TelehealthQualityMetricsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TelehealthQualityMetricsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TelehealthQualityMetricsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
