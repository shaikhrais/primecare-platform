import 'package:primecare_models/primecare_models.dart';

class QualityAssuranceReportsModel extends BaseScreenState<QualityAssuranceReportsModel> {
  const QualityAssuranceReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  QualityAssuranceReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => QualityAssuranceReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
