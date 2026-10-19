import 'package:primecare_models/primecare_models.dart';

class QualityAssuranceMetricsModel extends BaseScreenState<QualityAssuranceMetricsModel> {
  const QualityAssuranceMetricsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  QualityAssuranceMetricsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => QualityAssuranceMetricsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
