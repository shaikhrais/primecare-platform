import 'package:primecare_models/primecare_models.dart';

class QualityMetricsModel extends BaseScreenState<QualityMetricsModel> {
  const QualityMetricsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  QualityMetricsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => QualityMetricsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
