import 'package:primecare_models/primecare_models.dart';

class QualityAssuranceAnalyticsModel extends BaseScreenState<QualityAssuranceAnalyticsModel> {
  const QualityAssuranceAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  QualityAssuranceAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => QualityAssuranceAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
